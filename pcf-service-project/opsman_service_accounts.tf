resource "google_project_iam_custom_role" "opsman_role" {
  role_id     = "${var.env_name}_opsman_role"
  title       = "opsman"
  description = "Ops Manager Role"
  permissions = [
    "compute.addresses.get",
    "compute.addresses.list",
    "compute.backendServices.get",
    "compute.backendServices.list",
    "compute.diskTypes.get",
    "compute.disks.delete",
    "compute.disks.list",
    "compute.disks.get",
    "compute.disks.createSnapshot",
    "compute.snapshots.create",
    "compute.disks.create",
    "compute.images.useReadOnly",
    "compute.globalOperations.get",
    "compute.images.delete",
    "compute.images.get",
    "compute.images.create",
    "compute.instanceGroups.get",
    "compute.instanceGroups.list",
    "compute.instanceGroups.update",
    "compute.instances.setMetadata",
    "compute.instances.setLabels",
    "compute.instances.setTags",
    "compute.instances.reset",
    "compute.instances.start",
    "compute.instances.list",
    "compute.instances.get",
    "compute.instances.delete",
    "compute.instances.create",
    "compute.subnetworks.use",
    "compute.subnetworks.useExternalIp",
    "compute.instances.detachDisk",
    "compute.instances.attachDisk",
    "compute.disks.use",
    "compute.instances.deleteAccessConfig",
    "compute.instances.addAccessConfig",
    "compute.addresses.use",
    "compute.machineTypes.get",
    "compute.regionOperations.get",
    "compute.zoneOperations.get",
    "compute.networks.get",
    "compute.subnetworks.get",
    "compute.snapshots.delete",
    "compute.snapshots.get",
    "compute.targetPools.list",
    "compute.targetPools.get",
    "compute.targetPools.addInstance",
    "compute.targetPools.removeInstance",
    "compute.instances.use",
    "storage.buckets.create",
    "storage.objects.create",
    "resourcemanager.projects.get",
    "compute.zones.list",
    "compute.subnetworks.get",
    "compute.subnetworks.list",
    "compute.instances.setServiceAccount",
    "compute.regionBackendServices.get",
    "compute.regionBackendServices.list"
  ]
}

resource "random_id" "ops_manager_account" {
  byte_length = 4
}

resource "google_service_account" "ops_manager" {
  display_name = "${var.env_name} Ops Manager"
  account_id   = "${var.env_name}-ops-${random_id.ops_manager_account.hex}"
}

resource "google_project_iam_member" "ops_manager" {
  project = "${var.project}"
  role    = "projects/${var.project}/roles/${google_project_iam_custom_role.opsman_role.role_id}"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}

resource "google_project_iam_member" "service_account_user" {
  project = "${var.project}"
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.ops_manager.email}"
}
