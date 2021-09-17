
terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    http = {
      source = "hashicorp/http"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}
