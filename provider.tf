provider "google" {
  region  = "${var.compute_region}"
  project = "${var.provider_project_id}"
}

terraform {
  version = "= 0.11.13"
}
