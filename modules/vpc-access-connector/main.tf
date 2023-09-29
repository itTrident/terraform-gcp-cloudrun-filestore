locals {
  project_id = "${length(var.project_id) > 0 ? var.project_id : data.google_client_config.current.project}"
  region     = "${length(var.region) > 0 ? var.region : data.google_client_config.current.region}"
  
  network_vpc = length(var.subnet) == 0 ? var.network_vpc : null

  ip_cidr_range = length(var.subnet) == 0 ? var.ip_cidr_range : null
}

resource "google_vpc_access_connector" "connector" {
  count         = var.module_enabled ? 1 : 0
  name          = var.name
  ip_cidr_range = local.ip_cidr_range
  network       = local.network_vpc
  region        = local.region
  project       = local.project_id
  machine_type  = var.machine_type
  min_throughput = var.min_throughput
  max_throughput = var.max_throughput
  min_instances = var.min_instances
  max_instances  = var.max_instances
  dynamic subnet {
    for_each = try(var.subnet, [])
    content {
      name = try(subnet.value.subnet_name, null)
      project_id  = try(local.project_id, null)
    }
  }
  timeouts {
    create = try(var.module_timeouts.google_vpc_access_connector.create, "6m")
    delete = try(var.module_timeouts.google_vpc_access_connector.delete, "4m")
  }
}