variable "connection_user" {
  type        = "string"
  description = "SSH username."
}

variable "connection_host" {
  type        = "string"
  description = "SSH remote host (IP or name)."
}

variable "connection_private_key" {
  type        = "string"
  description = "SSH RSA private key material. Not a path to a file."
}

variable "connection_port" {
  type        = "string"
  default     = "22"
  description = "SSH remote port."
}
