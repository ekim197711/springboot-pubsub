resource "google_cloud_run_service" "cr" {
  name                       = "mikesapp"
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
      service_account_name = "${var.service_account_email}"
      containers {
        image = "${var.region}-docker.pkg.dev/${var.project_name}/docker-registry/mikes-demo-app:latest"
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