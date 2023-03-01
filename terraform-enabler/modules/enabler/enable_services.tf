resource "google_project_service" "project_service_iam" {
  for_each = var.services
  project = var.project_name
  service = each.key
}
