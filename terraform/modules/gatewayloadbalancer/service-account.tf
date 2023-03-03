
resource "google_project_iam_member" "demo-engine-iam-pubsub-admin" {
  project = "${var.project_name}"
  role    = "roles/pubsub.admin"
  member  = "serviceAccount:demo-client@${var.project_name}.iam.gserviceaccount.com"
}

resource "google_service_account" "demo_client" {
  account_id   = "demo-client"
  display_name = "demo Client"
}