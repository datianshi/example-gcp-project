resource "google_compute_forwarding_rule" "cf-external" {
  name        = "${var.env_name}-cf-external"
  target      = "${google_compute_target_pool.cf-external.self_link}"
  project     = "${google_project.pcf_project.project_id}"
  port_range  = "443-443"
  ip_protocol = "TCP"
  ip_address  = "${google_compute_address.cf-external.address}"
}

resource "google_compute_address" "cf-external" {
  name = "${var.env_name}-cf-external"
  project     = "${google_project.pcf_project.project_id}"
}

resource "google_compute_target_pool" "cf-external" {
  name             = "${var.env_name}-cf-external"
  project     = "${google_project.pcf_project.project_id}"
  health_checks = [
    "${google_compute_http_health_check.cf-external.name}",
  ]
}

resource "google_compute_http_health_check" "cf-external" {
  project     = "${google_project.pcf_project.project_id}"
  name               = "default"
  request_path       = "/health"
  port = "8080"
  check_interval_sec = 1
  timeout_sec        = 1
}
