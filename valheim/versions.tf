
terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    null = {
      source = "hashicorp/null"
    }
  }
}
