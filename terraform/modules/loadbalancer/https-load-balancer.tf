data "google_secret_manager_secret_version" "certificate" {
  project = var.shared_mgmt_project
  secret  = var.certificate_secret
}

data "google_secret_manager_secret_version" "private_key" {
  project = var.shared_mgmt_project
  secret  = var.private_key_secret
}

resource "google_compute_global_forwarding_rule" "this" {
  provider   = google-beta
  project    = var.project_name
  name       = "${var.name_prefix}-https"
  target     = google_compute_target_https_proxy.https_proxy.self_link
  ip_address = google_compute_global_address.global_address.address
  port_range = "443"
}

resource "google_compute_global_address" "global_address" {
  provider   = google-beta
  project    = var.project_name
  name       = "${var.name_prefix}-address"
  ip_version = "IPV4"
}

resource "google_compute_target_https_proxy" "https_proxy" {
  project = var.project_name
  name    = "${var.name_prefix}-https-proxy"
  url_map = google_compute_url_map.url_map.self_link

  #  ssl_certificates = [google_compute_ssl_certificate.ssl_certificate.self_link]
  ssl_certificates = [google_compute_managed_ssl_certificate.managed_cert.self_link]
  ssl_policy       = ""
  quic_override    = "NONE"
}

#resource "google_compute_ssl_certificate" "ssl_certificate" {
#  project     = var.project_name
#  name_prefix = "${var.name_prefix}-cert-"
#  certificate = data.google_secret_manager_secret_version.certificate.secret_data
#  private_key = data.google_secret_manager_secret_version.private_key.secret_data
#
#  lifecycle {
#    create_before_destroy = true
#  }
#}

resource "google_compute_managed_ssl_certificate" "managed_cert" {
  name = "managed-cert-${random_id.id.hex}"

  lifecycle {
    create_before_destroy = true
  }

  managed {
    domains = [var.managed_ssl_certificate_domain]
  }
}

resource "random_id" "id" {
  keepers = {
    domain   = tostring(var.managed_ssl_certificate_domain)
    backends = md5(join("", keys(var.backends)))
  }
  byte_length = 4
}

resource "google_compute_url_map" "url_map" {
  project         = var.project_name
  name            = "${var.name_prefix}-url-map-${random_id.id.hex}"
  default_service = google_compute_backend_service.backend_service_api_gateway.id

  host_rule {
    hosts        = [var.managed_ssl_certificate_domain]
    path_matcher = "mikes-demo"
  }

  path_matcher {
    name            = "mikes-demo"
    default_service = google_compute_backend_service.backend_service_api_gateway.id

    dynamic "path_rule" {
      for_each = var.backends
      content {
        paths   = ["/${path_rule.key}/*"]
        service = google_compute_backend_service.backend_service_api_gateway.id
        route_action {
          url_rewrite {
            path_prefix_rewrite = "/"
          }
        }
      }
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_backend_service" "backend_service_api_gateway" {
  provider = google-beta

  project = var.project_name
  name    = "${var.name_prefix}-backend-api-gateway"


  description                     = "api_gateway"
  connection_draining_timeout_sec = 10
  enable_cdn                      = false
  custom_request_headers          = []
  custom_response_headers         = []
  log_config {
    enable      = true
    sample_rate = 1.0
  }

  # To achieve a null backend security_policy, set each.value.security_policy to "" (empty string), otherwise, it fallsback to var.security_policy.
  security_policy = ""

}