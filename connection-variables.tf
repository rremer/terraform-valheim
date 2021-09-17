variable "connection_credentials_path" {
  type        = string
  default     = "~/.ssh/id_rsa"
  description = "Path to credentials file for compute connectivity."
}

variable "connection_public_credentials_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to credentials file for provisioning compute connectivity."
}

variable "connection_public_ipv4_api_url" {
  type        = string
  default     = "http://icanhazip.com"
  description = "URL to an API for returning the provisioning machines public NAT IPv4 address."
}

