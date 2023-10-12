locals {
vpc_access_connector = join("", module.serverless-vpc-access-connector.self_link)
nfs_mount_point  = module.filestore.nfs_mount_point
}

module filestore {
  module_enabled = true
  source = "../modules/filestore"
  name = "tt"
  file_shares = [{capacity_gb = 1048, name = "test", nfs_export_options = [{ ip_ranges = ["0.0.0.0/0"] }]} ]
  network = [{network = "default", network_mode = ["MODE_IPV4"], connect_mode = "DIRECT_PEERING"}]
}

module serverless-vpc-access-connector {
  module_enabled = true
  source = "../modules/serverless-vpc-access-connector"
  name = "test"
  ip_cidr_range = "10.2.0.0/28"
  network_vpc = "default"
}


module "cloud-runV2" {
  module_enabled = true
  source                     = "../modules/cloud-runV2"
  name                       = "nginx"
  execution_environment      = "EXECUTION_ENVIRONMENT_GEN2"
  containers_temp            = [{ name = "plum", image = "nginx:latest", env = [{ name = "FILE_STORE_ENDPOINT", value = local.nfs_mount_point }], value_source = [], ports = [{ container_port = 80 }], volume_mounts = [] }]
  scaling_config             = [{ min_instance_count = 0, max_instance_count = 100 }]
  vpc_access                 = [{connector = local.vpc_access_connector, egress = "PRIVATE_RANGES_ONLY"}]
  ingress                    = "INGRESS_TRAFFIC_ALL"
}
