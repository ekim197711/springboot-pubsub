variable "project_name" {
  type = string
}

variable "region" {
  type = string
}
variable "location" {
  type = string
}
variable "api_gateway_service" {
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
variable "managed_ssl_certificate_domain" {
  description = "Create Google-managed SSL certificates for specified domains. Requires `ssl` to be set to `true` and `use_ssl_certificates` set to `false`."
  type        = string

}
