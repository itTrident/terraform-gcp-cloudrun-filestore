
terraform {
  # required_version = ">= 0.14"

  required_providers {
    # Cloud Run support was added on 3.3.0
    google = ">= 4.83.0"
  }
}

provider "google" {
  # credentials = ""
  project = ""
  region  = "us-central1"
  zone    = "us-central1-c"
}