resource "google_compute_network" "cf-network" {
  name                    = "cf-network"
  project = "${var.cf_project}"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "iso-network" {
  name                    = "iso-network"
  project = "${var.cf_project}"
  auto_create_subnetworks = "false"
}

resource "google_compute_network" "mgmt-network" {
  name                    = "mgmt-network"
  project = "${var.mgmt_project}"
  auto_create_subnetworks = "false"
}

resource "google_compute_shared_vpc_service_project" "service_project_mgmt" {
  host_project    = "${var.mgmt_project}"
  service_project = "${var.project}"
}

# resource "google_compute_shared_vpc_service_project" "service_project_iso" {
#   host_project    = "${var.cf_project}"
#   service_project = "${var.project}"
# }
#
# resource "google_compute_shared_vpc_service_project" "service_project_cf" {
#   host_project    = "${var.cf_project}"
#   service_project = "${var.project}"
# }

resource "google_compute_network_peering" "mgmt-cf" {
  name = "mgmt-cf"
  network = "${google_compute_network.mgmt-network.self_link}"
  peer_network = "${google_compute_network.cf-network.self_link}"
}

resource "google_compute_network_peering" "mgmt-iso" {
  name = "mgmt-iso"
  network = "${google_compute_network.mgmt-network.self_link}"
  peer_network = "${google_compute_network.iso-network.self_link}"
}

resource "google_compute_network_peering" "iso-cf" {
  name = "iso-cf"
  network = "${google_compute_network.iso-network.self_link}"
  peer_network = "${google_compute_network.cf-network.self_link}"
}

resource "google_compute_network_peering" "cf-iso" {
  name = "cf-iso"
  network = "${google_compute_network.cf-network.self_link}"
  peer_network = "${google_compute_network.iso-network.self_link}"
}



# resource "google_compute_subnetwork" "pas-subnet" {
#   name          = "${var.env_name}-pas-subnet"
#   ip_cidr_range = "${var.pas_subnet_range}"
#   private_ip_google_access  = "true"
#   network       = "${var.network}"
#   region        = "${var.region}"
# }
