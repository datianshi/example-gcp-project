resource "random_id" "terraform_account" {
  byte_length = 4
}

resource "google_service_account" "terraform_service_account" {
  display_name = "${var.short_env_name} terraform service account"
  project = "${var.management_project}"
  account_id   = "${var.short_env_name}-ops-${random_id.terraform_account.hex}"
}

resource "google_project_iam_member" "terraform_network_user" {
  project = "${var.project}"
  role    = "roles/compute.networkViewer"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}

resource "google_project_iam_member" "compute_admin" {
  project = "${google_project.pcf_project.project_id}"
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}

resource "google_project_iam_member" "service_account_admin" {
  project = "${google_project.pcf_project.project_id}"
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}

resource "google_project_iam_member" "service_account_key_admin" {
  project = "${google_project.pcf_project.project_id}"
  role    = "roles/iam.serviceAccountKeyAdmin"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}

resource "google_project_iam_member" "cloud_storage_admin" {
  project = "${google_project.pcf_project.project_id}"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}
resource "google_project_iam_member" "role_admin" {
  project = "${google_project.pcf_project.project_id}"
  role    = "roles/iam.roleAdmin"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}
resource "google_project_iam_member" "iam_admin" {
  project = "${google_project.pcf_project.project_id}"
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}

resource "google_project_iam_member" "terraform_service_account_user" {
  project = "${google_project.pcf_project.project_id}"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.terraform_service_account.email}"
}
