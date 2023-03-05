
module "gatewayloadbalancer" {
  source       = "../../modules/gatewayloadbalancer"
  project_name = local.project_name
  region       = local.region
  location = local.location
  managed_ssl_certificate_domain = local.domain
  api_gateway_service = "demo-api-gateway"
  openapi_template_vars = {
    project_name    = local.project_name
    backend_address = "https://mikes-cloud-run-xdqrgy4k7a-lm.a.run.app"
  }
}
