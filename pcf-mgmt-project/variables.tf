variable "env_name" {}
variable "region" {}
variable "project" {}
variable "cf_project" {}
variable "iso_project" {}
variable "mgmt_project" {}
variable "billing_id" {}
variable "opsman_machine_type" {}
variable "opsman_image_url" {}
variable "opsman_ip" {}

variable "infra_subnet_range" {
}
variable "pas_subnet_range" {
}
variable "services_subnet_range" {
}
variable "iso_subnet_range" {
}
variable "nat_instance_count" {
  default = "1"
}
variable "zones" {
  type = "list"
}
variable "nat_tag" {
  default = "nat_out"
}
variable "folder_id" {
}
variable "internal_lb_address" {}
