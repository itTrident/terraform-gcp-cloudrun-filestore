locals {
  project_id = "${length(var.project_id) > 0 ? var.project_id : data.google_client_config.current.project}"
  location     = "${length(var.location) > 0 ? var.location : data.google_client_config.current.region}"
  region     = var.tier == "ENTERPRISE" ? local.location : data.google_client_config.current.zone
}

resource "google_filestore_instance" "instance" {
  count = var.module_enabled ? 1 : 0
  depends_on = [var.module_depends_on]
  name     = var.name
  location = local.region
  project  = local.project_id
  labels   = var.labels
  kms_key_name = var.kms_key_name
  description  = var.description
  tier     = var.tier

  dynamic file_shares {
    for_each = try(var.file_shares, [])
    content {
      capacity_gb = try(file_shares.value.capacity_gb, 2560)
      name        = try(file_shares.value.name, null)
  
      dynamic nfs_export_options {
        for_each = try(file_shares.value.nfs_export_options, [])
        content {
          ip_ranges   = try(nfs_export_options.value.ip_ranges, [])
          access_mode = try(nfs_export_options.value.access_mode, "READ_WRITE")
          squash_mode = try(nfs_export_options.value.squash_mode, "NO_ROOT_SQUASH")
          anon_uid    = try(nfs_export_options.value.anon_uid, null)
          anon_gid    = try(nfs_export_options.value.anon_gid, null)
        }
      }
    }
  }

  dynamic networks { 
    for_each = var.network
    content {
      network      = try(networks.value.network, null)
      modes        = try(networks.value.network_mode, [])
      reserved_ip_range = try(networks.value.reserved_ip_range, null)
      connect_mode = try(networks.value.connect_mode, null)
      ip_addresses = try(networks.value.ip_addresses, null)
    }
  }

  timeouts {
    create = try(var.module_timeouts.google_filestore_instance.create, "6m")
    update = try(var.module_timeouts.google_filestore_instance.update, "15m")
    delete = try(var.module_timeouts.google_filestore_instance.delete, "4m")
  }
}