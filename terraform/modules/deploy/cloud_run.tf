resource "google_cloud_run_service" "mikes-cloud-run" {
  name                       = "mikes-cloud-run"
  location                   = var.region
  autogenerate_revision_name = true
  timeouts {
    create = "1m"
  }
  template {
    metadata {
      annotations = {
        "autoscaling.knative.dev/minScale"  = "1"
        "autoscaling.knative.dev/maxScale"  = "10"
        "run.googleapis.com/cpu-throttling" = "false"
      }
    }
    spec {
#      service_account_name = "mikes-cloud-run-engine@${var.project_name}.iam.gserviceaccount.com"
      service_account_name = var.service_account_email
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_name}/docker-registry/mikesdemo:latest"
        resources {
          limits = {
            memory = "1536Mi"
          }
        }
        ports {
          name           = "http1"
          protocol       = "TCP"
          container_port = 8080
        }
        env {
          name  = "SPRING_PROFILES_ACTIVE"
          value = "dev"
        }
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}