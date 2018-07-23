resource "google_project" "pcf_project" {
  name = "${var.env_name}-pcf-project"
  project_id = "${var.env_name}-pcf-project"
  folder_id     = "${var.folder_id}"
  billing_account = "${var.billing_id}"
  skip_delete = "true"
}

resource "google_compute_shared_vpc_service_project" "service_project_cf" {
  host_project    = "${var.cf_project}"
  service_project = "${google_project.pcf_project.project_id}"
}
