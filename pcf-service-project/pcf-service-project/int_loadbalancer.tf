resource "google_compute_forwarding_rule" "cf-internal" {
  name       = "${var.env_name}-cf-internal"
  load_balancing_scheme = "INTERNAL"
  ports = ["443"]
  network = "${var.network}"
  subnetwork = "${var.pas_subnet}"
  ip_address = "${var.internal_lb_address}"

  backend_service = "${google_compute_region_backend_service.http_lb_backend_service.self_link}"
}

resource "google_compute_region_backend_service" "http_lb_backend_service" {
  name        = "${var.env_name}-internal-httpslb"
  protocol    = "TCP"
  timeout_sec = 10

  backend {
    group = "${google_compute_instance_group.httplb.0.self_link}"
  }

  backend {
    group = "${google_compute_instance_group.httplb.1.self_link}"
  }

  backend {
    group = "${google_compute_instance_group.httplb.2.self_link}"
  }

  health_checks = ["${google_compute_health_check.cf-internal.self_link}"]
}

resource "google_compute_instance_group" "httplb" {
  // Count based on number of AZs
  count       = 3
  name        = "${var.env_name}-lb-instance-group-${element(var.zones, count.index)}"
  description = "Instance Group for internal http router"
  zone        = "${element(var.zones, count.index)}"
  network = "${var.network}"
}

resource "google_compute_health_check" "cf-internal" {
  name                = "${var.env_name}-cf-internal"
  check_interval_sec  = 5
  timeout_sec         = 3
  healthy_threshold   = 6
  unhealthy_threshold = 3

  http_health_check {
    port                = 8080
    request_path        = "/health"
  }
}
