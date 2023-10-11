locals {
  project_id = "${length(var.project_id) > 0 ? var.project_id : data.google_client_config.current.project}"
  location     = "${length(var.location) > 0 ? var.location : data.google_client_config.current.region}"
}

resource "google_cloud_run_v2_service" "default" {
  count = var.module_enabled ? 1 : 0
  depends_on = [var.module_depends_on]
  name     = var.name
  project  = local.project_id
  location = local.location
  ingress = var.ingress

  timeouts {
    create = try(var.module_timeouts.google_cloud_run_v2_service.create, "6m")
    update = try(var.module_timeouts.google_cloud_run_v2_service.update, "15m")
    delete = try(var.module_timeouts.google_cloud_run_v2_service.delete, "4m")
  }

  template {
    execution_environment = var.execution_environment
    service_account = var.service_account
    labels = var.labels
    annotations = var.annotations 
    dynamic scaling {
      for_each = try(var.scaling_config, [])
      content {
        min_instance_count = try(scaling.value.min_instance_count, 0)
        max_instance_count = try(scaling.value.max_instance_count, 100)
      }
    }
    dynamic volumes {
      for_each = try(var.volumes, [])
      content {
        name = try(volumes.value.name, null)
        dynamic secret {
          for_each = try(volumes.value.secret, [])
          content {
            secret = try(secret.value.secret, null)
            default_mode  = try(secret.value.default_mode, null)
            items {
              path  = try(secret.value.items.path, null)
              version = try(secret.value.items.version, null)
              mode = try(secret.value.items.mode, null)
            }
          }
        }
        cloud_sql_instance {
          instances = try(volumes.value.cloud_sql_instance, null)
        }
      }
    }
    dynamic vpc_access {
      for_each = try(var.vpc_access, [])
      content {
        connector = try(vpc_access.value.connector, null)
        egress    = try(vpc_access.value.egress, null)
      } 
    }
    dynamic containers {
      for_each = try(var.containers_temp, [])
      content {
        image = try(containers.value.image, null)
        name = try(containers.value.name, null)
        command = try(containers.value.command, null)
        args = try(containers.value.args, null)
        dynamic env {
          for_each = try(containers.value.env, [])
          content {
            name = try(env.value.name, null)
            value = try(env.value.value, null)
          
            dynamic value_source {
              for_each = try(containers.value.value_source, [])
              content {
                secret_key_ref {
                  secret = try(value_source.value.secret, null)
                  version = try(value.value_source.version, "latest")
                }
              }
            }
          }
        }
        dynamic resources {
          for_each = try(containers.value.resources, [])
          content {
            limits = try(resource.value.limits, null)
            cpu_idle = try(resource.value.cpu_idle, null)
            startup_cpu_boost = try(resource.value.startup_cpu_boost, null)
          }
        }
        dynamic "ports" {
            for_each = try (containers.value.ports, [])
            content {
              name           = try(ports.value.name, null)
              container_port = try(ports.value.container_port, null)
            }
          } 
        dynamic "volume_mounts" {
            for_each = try (containers.value.volume_mounts, [])
            content {
              mount_path = try(volume_mounts.value.mount_path, null)
              name = try(volume_mounts.value.name, null)
            }
          }
        working_dir = try(containers.value.working_dir, null)
      }
    }
  }
}

resource "google_cloud_run_service_iam_binding" "default" {
  depends_on  = [google_cloud_run_v2_service.default]
  count = var.module_enabled ? 1 : 0
  location = google_cloud_run_v2_service.default[0].location
  service  = google_cloud_run_v2_service.default[0].name
  project = google_cloud_run_v2_service.default[0].project
  role     = "roles/run.invoker"
  members = [
    "allUsers"
  ]
}
