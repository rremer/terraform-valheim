variable "ports_udp" {
  type        = "list"
  description = "The UDP ports to serve on."
  default     = ["2456", "2457"]
}

variable "ports_tcp" {
  type        = "list"
  description = "The TCP ports to serve on."
  default     = ["2456", "2457"]
}

variable "blocked_by" {
  type        = "string"
  description = "A string to block execution by via terraform graph dependency waits."
  default     = ""
}
