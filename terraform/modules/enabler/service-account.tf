resource "google_service_account" "application-account" {
  account_id   = "mikes-application"
  display_name = "Mikes application"
  project      = var.project_name
}

resource "google_project_iam_member" "application-account-roles" {
  for_each = var.roles
  project = "${var.project_name}"
  role    = each.key
  member  = "serviceAccount:${google_service_account.application-account.account_id}@${var.project_name}.iam.gserviceaccount.com"
}

output "service_account_email" {
  value = google_service_account.application-account.email
}
