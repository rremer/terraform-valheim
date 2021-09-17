data "http" "public_ipv4" {
  url = var.connection_public_ipv4_api_url
}

resource "google_compute_firewall" "app" {
  name     = "${var.global_app_name}-app"
  network  = "default"
  priority = 100

  allow {
    protocol = "udp"
    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    ports = [module.this.ports_udp]
  }

  allow {
    protocol = "tcp"
    # TF-UPGRADE-TODO: In Terraform v0.10 and earlier, it was sometimes necessary to
    # force an interpolation expression to be interpreted as a list by wrapping it
    # in an extra set of list brackets. That form was supported for compatibility in
    # v0.11, but is no longer supported in Terraform v0.12.
    #
    # If the expression in the following list itself returns a list, remove the
    # brackets to avoid interpretation as a list of lists. If the expression
    # returns a single list item then leave it as-is and remove this TODO comment.
    ports = [module.this.ports_tcp]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.global_app_name]
}

resource "google_compute_firewall" "ssh" {
  name     = "${var.global_app_name}-ssh"
  network  = "default"
  priority = 100

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [trimspace(data.http.public_ipv4.body)]
  target_tags   = [var.global_app_name]
}

resource "google_compute_firewall" "ping" {
  name     = "${var.global_app_name}-ping"
  network  = "default"
  priority = 100

  allow {
    protocol = "icmp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.global_app_name]
}

resource "google_compute_firewall" "default" {
  name     = "${var.global_app_name}-default-deny"
  network  = "default"
  priority = 900

  deny {
    protocol = "all"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = [var.global_app_name]
}

