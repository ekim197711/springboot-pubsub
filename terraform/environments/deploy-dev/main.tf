module "enabler" {
  source       = "../../modules/enabler"
  project_name = local.project_name
  region       = local.region
  environment  = local.environment

}

module "deploy" {
  depends_on = [module.enabler]
  source       = "../../modules/deploy"
  project_name = local.project_name
  region       = local.region
  environment  = local.environment
  service_account_email = module.enabler.service_account_email
}

