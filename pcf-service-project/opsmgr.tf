resource "google_compute_image" "ops-manager-image" {
  name           = "${var.env_name}-ops-manager-image"
  create_timeout = 20

  raw_disk {
    source = "${var.opsman_image_url}"
  }
}

resource "google_compute_instance" "ops-manager" {
  name           = "${var.env_name}-ops-manager"
  machine_type   = "${var.opsman_machine_type}"
  zone           = "${element(var.zones, 1)}"
  create_timeout = 10
  tags           = ["${var.env_name}-ops-manager"]

  boot_disk {
    initialize_params {
      image = "${google_compute_image.ops-manager-image.self_link}"
      size  = 250
      type  = "pd-ssd"
    }
  }

  network_interface {
    subnetwork = "${var.infra_subnet}"
    address    = "${var.opsman_ip}"
  }
}
