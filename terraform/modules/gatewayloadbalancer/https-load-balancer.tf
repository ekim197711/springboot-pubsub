resource "google_compute_global_forwarding_rule" "this" {
  provider   = google-beta
  project    = var.project_name
  name       = "demo-https"
  target     = google_compute_target_https_proxy.https_proxy.self_link
  ip_address = google_compute_global_address.global_address.address
  port_range = "443"
}

resource "google_compute_global_address" "global_address" {
  provider   = google-beta
  project    = var.project_name
  name       = "demo-address"
  ip_version = "IPV4"
}

resource "google_compute_target_https_proxy" "https_proxy" {
  project = var.project_name
  name    = "demo-https-proxy"
  url_map = google_compute_url_map.url_map_other.self_link

  #  ssl_certificates = [google_compute_ssl_certificate.ssl_certificate.self_link]
  ssl_certificates = [google_compute_managed_ssl_certificate.managed_cert.self_link]
  ssl_policy       = ""
  quic_override    = "NONE"
}


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
  }
  byte_length = 4
}

resource "google_compute_url_map" "url_map_other" {
  project         = var.project_name
  name            = "url-map-demo"
  default_service = google_compute_backend_service.backend_service_api_gateway.id

  host_rule {
    hosts        = [var.managed_ssl_certificate_domain]
    path_matcher = "mikes-demo"
  }

  path_matcher {
    name            = "mikes-demo"
    default_service = google_compute_backend_service.backend_service_api_gateway.id

    dynamic "path_rule" {
      for_each = ["mikesdemo"]
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
  name    = "${var.api_gateway_service}"


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