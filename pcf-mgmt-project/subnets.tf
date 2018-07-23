resource "google_compute_subnetwork" "infra-subnet" {
  name          = "${var.env_name}-infra-subnet"
  ip_cidr_range = "${var.infra_subnet_range}"
  private_ip_google_access  = "true"
  network       = "${google_compute_network.cf-network.self_link}"
  region        = "${var.region}"
  project       = "${var.cf_project}"
}

resource "google_compute_subnetwork" "pas-subnet" {
  name          = "${var.env_name}-pas-subnet"
  ip_cidr_range = "${var.pas_subnet_range}"
  private_ip_google_access  = "true"
  network       = "${google_compute_network.cf-network.self_link}"
  region        = "${var.region}"
  project       = "${var.cf_project}"
}

resource "google_compute_subnetwork" "services-subnet" {
  name          = "${var.env_name}-services-subnet"
  ip_cidr_range = "${var.services_subnet_range}"
  private_ip_google_access  = "true"
  network       = "${google_compute_network.cf-network.self_link}"
  region        = "${var.region}"
  project       = "${var.cf_project}"
}

resource "google_compute_subnetwork" "iso-subnet" {
  name          = "${var.env_name}-iso-subnet"
  ip_cidr_range = "${var.iso_subnet_range}"
  private_ip_google_access  = "true"
  network       = "${google_compute_network.iso-network.self_link}"
  region        = "${var.region}"
  project       = "${var.cf_project}"
}
