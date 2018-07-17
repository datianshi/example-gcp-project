variable "env_name" {
}
variable "network" {
}
variable "region" {
}
variable "infra_subnet_range" {
}
variable "pas_subnet_range" {
}
variable "services_subnet_range" {
}
variable "nat_machine_type" {
  default = "n1-standard-1"
}
variable "nat_instance_count" {
  default = "3"
}
variable "zones" {
  type = "list"
}
variable "nat_tag" {
  default = "pcf-nat-tag"
}
variable "vpn_tag" {
  default = "pcf-vpn-tag"
}
variable "on_premise_range" {
}
variable "cf_public_src_range" {
}
variable "vpn_tunnel" {
}
variable "nat_dest_range" {
}
variable "project_id" {
}
variable "org_id" {
}
