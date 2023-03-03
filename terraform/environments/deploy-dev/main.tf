
module "gatewayloadbalancer" {
  depends_on = [module.deploy]
  source       = "../../modules/gatewayloadbalancer"
  project_name = local.project_name
  region       = local.region
  openapi_template_vars = {
    project_name    = local.project_name
    backend_address = "somebackend"
  }
}


module "deploy" {
  source       = "../../modules/deploy"
  project_name = local.project_name
  region       = local.region
  service_account_email =" mikes-demo@mikes-demo.iam.gserviceaccount.com"
}

