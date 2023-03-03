variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "backend_address" {
  type    = string
  default = "NOT_SET"
}

variable "openapi_template_vars" {
  type = object({
    project_name    = string
    backend_address = string
  })
}

#
