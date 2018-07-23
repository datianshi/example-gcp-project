resource "google_compute_image" "ops-manager-image" {
  name           = "${var.env_name}-ops-manager-image"
  create_timeout = 20

  raw_disk {
    source = "${var.opsman_image_url}"
  }
}

resource "google_compute_address" "opsman_ip" {
  name         = "${var.env_name}-my-internal-address"
  subnetwork   = "${var.infra_subnet}"
  address_type = "INTERNAL"
  address      = "${var.opsman_ip}"
  region       = "${var.region}"
}

resource "google_compute_instance" "ops-manager" {
  depends_on = ["google_compute_address.opsman_ip"]
  name           = "${var.env_name}-ops-manager"
  machine_type   = "${var.opsman_machine_type}"
  zone           = "${element(var.zones, 1)}"
  create_timeout = 10
  tags           = ["${var.env_name}-ops-manager","${var.env_name}", "ext-ssh"]
  project = "${var.project}"
//  service_account = ["${var.opsman_service_account}"]

  boot_disk {
    initialize_params {
      image = "${google_compute_image.ops-manager-image.self_link}"
      size  = 250
      type  = "pd-ssd"
    }
  }

  service_account {
    email = "${var.opsman_service_account}"
    scopes = ["cloud-platform"]
  }

  network_interface {
    subnetwork_project = "${var.shared_vpc_project}"
    subnetwork = "${var.infra_subnet}"
    address    = "${var.opsman_ip}"
  }
}
