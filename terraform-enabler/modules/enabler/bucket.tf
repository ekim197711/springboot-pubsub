resource "google_storage_bucket" "mikes-bucket" {
  name                        = "${var.project_name}-mikes-demo-bucket-deploy"
  force_destroy               = false
  uniform_bucket_level_access = true
  project                     = var.project_name
  location                    = var.region
  storage_class               = "STANDARD"
  versioning {
    enabled = true
  }
}
