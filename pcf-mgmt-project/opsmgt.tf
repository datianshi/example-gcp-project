resource "google_compute_image" "ops-manager-image" {
  name           = "${var.env_name}-ops-manager-image"
  project = "${google_project.pcf_project.project_id}"
  create_timeout = 20

  raw_disk {
    source = "${var.opsman_image_url}"
  }
}

# resource "google_compute_address" "opsman" {
#   name = "${var.env_name}-cf-opsman"
#   project     = "${google_project.pcf_project.project_id}"
# }

resource "google_compute_instance" "ops-manager" {
  project = "${google_project.pcf_project.project_id}"
  name           = "${var.env_name}-ops-manager"
  machine_type   = "${var.opsman_machine_type}"
  zone           = "${element(var.zones, 1)}"
  create_timeout = 10
  tags           = ["${var.env_name}-ops-manager"]
  allow_stopping_for_update = "true"

  boot_disk {
    initialize_params {
      image = "${google_compute_image.ops-manager-image.self_link}"
      size  = 50
      type  = "pd-ssd"
    }
  }

  service_account {
    email = "${google_service_account.ops_manager.email}"
    scopes = ["cloud-platform"]
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.infra-subnet.self_link}"
    address    = "${var.opsman_ip}"
    access_config {}
  }
}
