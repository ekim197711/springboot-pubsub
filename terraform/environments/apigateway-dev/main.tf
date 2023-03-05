
module "apigateway" {
  source       = "../../modules/api-gateway"
  project_name = local.project_name
  region       = local.region
  location = local.location
  managed_ssl_certificate_domain = local.domain
  openapi_template_vars = {
    project_name    = local.project_name
    backend_address = "https://mikes-cloud-run-xdqrgy4k7a-lm.a.run.app"
  }
}
