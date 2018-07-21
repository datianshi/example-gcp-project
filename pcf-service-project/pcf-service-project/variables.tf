variable "env_name" {
}
variable "short_env_name" {}
variable "network" {
}
variable "region" {
}
variable "opsman_image_url" {}
variable "opsman_ip" {}
variable "pas_subnet" {}
variable "infra_subnet" {}
variable "internal_lb_address" {}
variable "zones" {
  type = "list"
}
variable "opsman_machine_type" {
  default = "n1-standard-1"
}
variable "project" {}
variable "shared_vpc_project" {}
variable "opsman_service_account" {}
