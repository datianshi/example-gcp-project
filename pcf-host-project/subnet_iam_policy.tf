resource "google_compute_subnetwork_iam_binding" "services-subnet" {
  subnetwork = "${google_compute_subnetwork.services-subnet.name}"
  role       = "roles/compute.networkUser"

  members = [
    "serviceAccount:${google_service_account.terraform_service_account.email}",
    "serviceAccount:${google_service_account.ops_manager.email}",
  ]
}
resource "google_compute_subnetwork_iam_binding" "pas-subnet" {
  subnetwork = "${google_compute_subnetwork.pas-subnet.name}"
  role       = "roles/compute.networkUser"

  members = [
    "serviceAccount:${google_service_account.terraform_service_account.email}",
    "serviceAccount:${google_service_account.ops_manager.email}",
  ]
}
resource "google_compute_subnetwork_iam_binding" "infra-subnet" {
  subnetwork = "${google_compute_subnetwork.infra-subnet.name}"
  role       = "roles/compute.networkUser"

  members = [
    "serviceAccount:${google_service_account.terraform_service_account.email}",
    "serviceAccount:${google_service_account.ops_manager.email}",
  ]
}
