resource "google_compute_firewall" "pcf-internal" {
  name    = "${var.env_name}-pcf-internal"
  network = "${var.network}"

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
    "${google_compute_subnetwork.infra-subnet.ip_cidr_range}",
    "${google_compute_subnetwork.pas-subnet.ip_cidr_range}",
    "${google_compute_subnetwork.services-subnet.ip_cidr_range}",
  ]
}

resource "google_compute_firewall" "ops-manager" {
  name        = "${var.env_name}-ops-manager"
  network     = "${var.network}"
  target_tags = ["${var.env_name}-ops-manager"]

  allow {
    protocol = "tcp"
    ports    = ["443", "22"]
  }

  source_ranges = ["${var.on_premise_range}"]
}


resource "google_compute_firewall" "cf-public" {
  name    = "${var.env_name}-cf-public"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["${var.cf_public_src_range}"]
  target_tags = ["router"]
}

resource "google_compute_firewall" "cf-internal" {
  name    = "${var.env_name}-cf-internal"
  network = "${var.network}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  source_ranges = ["${var.on_premise_range}"]
  target_tags = ["router"]
}
