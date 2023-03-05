resource "google_api_gateway_api" "demo_api_gateway_api" {
  provider     = google-beta
  api_id       = "demo-api-gateway"
  display_name = "demo-api-gateway"
}

resource "random_string" "random" {
  length    = 16
  special   = false
  lower     = true
  min_lower = 16
}
resource "random_id" "rng" {
  keepers = {
    first = "${timestamp()}"
  }
  byte_length = 8
}

resource "google_service_account" "demo_api_gateway" {
  account_id   = "demo-api-gateway"
  display_name = "demo api gateway"
  project = var.project_name
}

resource "google_project_service" "service_api_gateway_enable" {
  project = var.project_name
  service = google_api_gateway_api.demo_api_gateway_api.managed_service
}

resource "google_project_iam_member" "demo_api_gateway_cloud_run_invoke" {
  project = "${var.project_name}"
  role    = "roles/run.invoker"
  member  = "serviceAccount:${google_service_account.demo_api_gateway.account_id}@${var.project_name}.iam.gserviceaccount.com"
}

resource "google_api_gateway_api_config" "api_cfg" {
  provider      = google-beta
  api           = google_api_gateway_api.demo_api_gateway_api.api_id
  api_config_id = "jwtconfig-${replace(lower(random_id.rng.id),"_","-")}"
  gateway_config {
    backend_config {
      google_service_account = google_service_account.demo_api_gateway.name
    }
  }
  openapi_documents {
    document {
      path     = "spec.yaml"
      contents = base64encode(templatefile("${path.module}/openapi-document/openapi_jwt.yaml", var.openapi_template_vars))
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_api_gateway_gateway" "demo_gateway_gateway" {
  provider   = google-beta
  region = "europe-west2"
  api_config = google_api_gateway_api_config.api_cfg.name
  gateway_id = "demo-api-gw"
}
