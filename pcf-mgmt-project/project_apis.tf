resource "google_project_service" "iam" {
  project = "${google_project.pcf_project.project_id}"
  service = "iam.googleapis.com"
  disable_on_destroy = "false"
}
resource "google_project_service" "cloudresource" {
  project = "${google_project.pcf_project.project_id}"
  service = "cloudresourcemanager.googleapis.com"
  disable_on_destroy = "false"
}
resource "google_project_service" "compute" {
  project = "${google_project.pcf_project.project_id}"
  service = "compute.googleapis.com"
  disable_on_destroy = "false"
}
