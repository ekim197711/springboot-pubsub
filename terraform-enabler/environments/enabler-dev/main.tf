module "enabler" {
  source       = "../../modules/enabler"
  project_name = local.project_name
  region       = local.region
  environment  = local.environment
}

