terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.51.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }

  }
}

provider "google" {
  project = local.project_name
  region  = local.region
}

provider "google-beta" {
  project = local.project_name
  region  = local.region
}
terraform {
  backend "gcs" {
    bucket = "mikes-demo-mikes-demo-bucket"
    prefix = "terraform/apigateway/state"
  }
}
provider "random" {
  # Configuration options
}