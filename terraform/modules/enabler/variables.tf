variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "services"{
  type= set(string)
  default = ["iam.googleapis.com"
  ,"cloudresourcemanager.googleapis.com"
  ,"pubsub.googleapis.com"
    ,"artifactregistry.googleapis.com"
    ,"apigateway.googleapis.com"
    ,"storage.googleapis.com"
    ,"servicecontrol.googleapis.com"
    ,"servicemanagement.googleapis.com"
    ,"run.googleapis.com"
    ,"apikeys.googleapis.com"
    ,"serviceusage.googleapis.com"
  ]
}

variable "roles"{
  type= set(string)
  default = ["roles/iam.serviceAccountAdmin"
    ,"roles/pubsub.admin"
    ,"roles/resourcemanager.projectIamAdmin"
     ,"roles/iam.serviceAccountAdmin"
      ,"roles/iam.serviceAccountKeyAdmin"
      ,"roles/apigateway.admin"
      ,"roles/serviceusage.apiKeysAdmin"
      ,"roles/artifactregistry.repoAdmin"
      ,"roles/artifactregistry.admin"
      ,"roles/run.admin"
      ,"roles/iam.serviceAccountUser"
     ,"roles/storage.admin"
      ,"roles/servicemanagement.admin"
      ,"roles/serviceusage.serviceUsageAdmin"
  ]
}

