resource "google_artifact_registry_repository" "docker-registry" {
  provider      = google
  project       = var.project_name
  location      = var.region
  repository_id = "docker-registry"
  description   = "Docker registry"
  format        = "DOCKER"
}
