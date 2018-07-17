resource "google_project" "pcf_project" {
  name = "${var.env_name}-pcf-project"
  project_id = "${var.project_id}"
  org_id     = "${var.org_id}"
}
