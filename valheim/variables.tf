variable "ports_udp" {
  type        = list(number)
  description = "The UDP ports to serve on."
  default     = [2456, 2457]
}

variable "ports_tcp" {
  type        = list(number)
  description = "The TCP ports to serve on."
  default     = [2456, 2457]
}

variable "blocked_by" {
  type        = string
  description = "A string to block execution by via terraform graph dependency waits."
  default     = ""
}

variable "server_name" {
  type        = string
  description = "The name of the Valheim world."
  default     = "valheim"
}

variable "server_password" {
  type        = string
  description = "The password for authenticating clients to the Valheim server."
}

