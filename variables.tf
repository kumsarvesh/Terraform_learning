variable "gcp_region" {
  type        = string
  description = "GCP Region"
  sensitive   = false
}

variable "gcp_zone" {
  type        = string
  description = "GCP zone"
  default     = "us-east1-b"
}

variable "gcp_CE_VM1" {
  type        = string
  description = "GCP CE Virtual machine 1"
  sensitive   = false
}

variable "gcp_CE_VM2" {
  type        = string
  description = "GCP CE Virtual machine 2tt"
  sensitive   = false
}

variable "gcp_CE_Machine_Type" {
  description = "VM machine type"
}

variable "gcp_vpc_network" {
  description = "GCP VPC network"
  sensitive   = true
}

variable "gcp_vpc_subnetwork" {
  description = "GCP VPC subnetwork"

}

variable "gcp_vpc_targettags" {
  description = "GCP VPC targettags"

}


variable "gcp_vm_instanceTemplate" {
  description = "gcp_vm_instanceTemplate"

}

variable "gcp_it_environment_label" {
  description = "gcp IT environment Label"

}