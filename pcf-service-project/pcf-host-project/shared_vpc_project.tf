resource "google_compute_shared_vpc_service_project" "service_project" {
  host_project    = "${var.project}"
  service_project = "${google_project.pcf_project.project_id}"
}
