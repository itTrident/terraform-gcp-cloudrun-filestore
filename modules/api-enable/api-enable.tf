locals {
  project_id = "${length(var.project) > 0 ? var.project : data.google_client_config.current.project}"
}

resource "google_project_service" "api-on" {
  count   =  length(var.api)
  depends_on = [var.module_depends_on]
  service = var.api[count.index]
  project = local.project_id

  disable_on_destroy = var.disable_on_destroy

 timeouts {
    create = try(var.module_timeouts.google_project_service.create, "20m")
    update = try(var.module_timeouts.google_project_service.update, "20m")
    delete = try(var.module_timeouts.google_project_service.delete, "20m")
  }
}