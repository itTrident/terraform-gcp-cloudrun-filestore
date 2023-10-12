output file_share_ip {
  value = google_filestore_instance.instance.networks.0.ip_addresses.0
}
output network {
  value = google_filestore_instance.instance.networks
}
