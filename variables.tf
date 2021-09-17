variable "server_name" {
  type        = string
  description = "The name of the Valheim world."
  default     = "valheim"
}

variable "server_password" {
  type        = string
  description = "The password for authenticating clients to the Valheim server."
}

