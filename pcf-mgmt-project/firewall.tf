resource "google_compute_firewall" "cf_internal_allow" {
  name    = "${var.env_name}-cf-internal"
  network = "${google_compute_network.cf-network.self_link}"
  project = "${var.cf_project}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    "10.0.0.0/16"
  ]
}

resource "google_compute_firewall" "mgmt_internal_allow" {
  name    = "${var.env_name}-mgmt-internal"
  network = "${google_compute_network.mgmt-network.self_link}"
  project = "${var.mgmt_project}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    "10.0.0.0/16"
  ]
}

resource "google_compute_firewall" "iso_internal_allow" {
  name    = "${var.env_name}-iso-internal"
  network = "${google_compute_network.iso-network.self_link}"
  project = "${var.cf_project}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_ranges = [
    "10.0.0.0/16"
  ]
}

resource "google_compute_firewall" "ops-manager" {
  name        = "${var.env_name}-ops-manager"
  network     = "${google_compute_network.cf-network.name}"
  project = "${var.cf_project}"
  target_tags = ["${var.env_name}-ops-manager"]

  allow {
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  source_ranges = ["0.0.0.0/0"]
}
#
#
# resource "google_compute_firewall" "cf-public" {
#   name    = "${var.env_name}-cf-public"
#   network = "${var.network}"
#
#   allow {
#     protocol = "tcp"
#     ports    = ["443"]
#   }
#
#   source_ranges = ["${var.cf_public_src_range}"]
#   target_tags = ["router"]
# }
#
# resource "google_compute_firewall" "cf-internal" {
#   name    = "${var.env_name}-cf-internal"
#   network = "${var.network}"
#
#   allow {
#     protocol = "tcp"
#     ports    = ["443"]
#   }
#
#   source_ranges = ["${var.on_premise_range}"]
#   target_tags = ["router"]
# }
