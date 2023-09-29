
module api-enable {
  source = "./modules/api-enable"
  project = "terraform-try-400205"
  api    = ["file.googleapis.com", "run.googleapis.com", "vpcaccess.googleapis.com"]
  disable_on_destroy = false
  module_timeouts = {
    google_project_service = {
      create = "5m" 
      delete = "5m"
      update = "5m"
      }
    }
}

module filestore {
  depends_on = [module.api-enable]
  module_enabled = true
  source = "./modules/filestore"
  name = "try"
  location = ""
  project_id = ""
  labels  = {}
  kms_key_name  = ""
  description = "this is test"
  tier  = "BASIC_HDD"
  file_shares = [{capacity_gb = 1048, name = "test", }] #nfs_export_options = [{ ip_ranges = ["0.0.0.0/0"] }]
  network = [{network = "default", network_mode = ["MODE_IPV4"], connect_mode = "DIRECT_PEERING"}]
  module_timeouts = {}
}

module vpc-access-connector {
  depends_on = [module.api-enable]
  module_enabled = true
  source = "./modules/vpc-access-connector"
  name = "test"
  project_id = ""
  subnet = []
  ip_cidr_range = "10.2.0.0/28"
  network_vpc = "default"
  module_timeouts = {}
}


module "cloud-runV2" {
  depends_on          = [module.vpc-access-connector, module.api-enable]
  module_enabled             = true
  source                     = "./modules/cloud-runV2"
  name                       = "nginx"
  project_id                 = ""
  location                   = "us-central1"
  annotations                = {}
  labels                     = {}
  execution_environment      = "EXECUTION_ENVIRONMENT_GEN2"
  module_timeouts            = {}
  containers_temp            = [{ name = "nginx", image = "nginx:latest", env = [{ name = "test", value = "testing" }], value_source = [], ports = [{ container_port = 80 }], volume_mounts = [] }]
  scaling_config             = [{ min_instance_count = 0, max_instance_count = 100 }]
  service_account            = ""
  vpc_access                 = [{connector = "projects/terraform-try-400205/locations/us-central1/connectors/test", egress = "PRIVATE_RANGES_ONLY"}]
  volumes                    = []
  ingress                    = "INGRESS_TRAFFIC_ALL"
}