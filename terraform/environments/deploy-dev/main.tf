
module "deploy" {
  source       = "../../modules/deploy"
  project_name = local.project_name
  region       = local.region
  location = local.location
  service_account_email ="mikes-application@mikes-demo.iam.gserviceaccount.com"

}

