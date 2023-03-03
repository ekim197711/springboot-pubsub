variable "shared_mgmt_project" {
  type = string
}
variable "project_name" {
  type = string
}
variable region {
  type = string
}

variable backend_address {
  type = string
}

variable certificate_secret {
  type = string
}
variable private_key_secret {
  type = string
}
variable default_service {
  type = string
}
variable "name_prefix" {
  type = string
}

variable "services" {
  type        = set(string)
  description = "The list of services which will be deployed to this project."

  validation {
    condition     = length(var.services) > 0
    error_message = "Services list empty, please supply at least one service."
  }
}
variable "managed_ssl_certificate_domain" {
  description = "Create Google-managed SSL certificates for specified domains. Requires `ssl` to be set to `true` and `use_ssl_certificates` set to `false`."
  type        = string

}

variable "backends" {
  description = "Map backend indices to list of backend maps."
  type        = map(object({
    description             = optional(string)
    enable_cdn              = optional(bool)
    security_policy         = optional(string)
    custom_request_headers  = optional(list(string))
    custom_response_headers = optional(list(string))

    log_config = optional(object({
      enable      = bool
      sample_rate = number
    }))

    groups = list(object({
      group = string
    }))

    iap_config = optional(object({
      enable               = bool
      oauth2_client_id     = string
      oauth2_client_secret = string
    }))
  }))
}