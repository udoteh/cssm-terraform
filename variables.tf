variable "vsphere_user" {
  description = "vSphere username"
  type        = string
}

variable "vsphere_password" {
  description = "vSphere password"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "vSphere server IP or hostname"
  type        = string
}

variable "datacenter" {
  description = "vSphere datacenter name"
  type        = string
}

variable "datastore" {
  description = "vSphere datastore name"
  type        = string
}

variable "cluster" {
  description = "vSphere compute cluster name"
  type        = string
}

variable "network" {
  description = "vSphere network name"
  type        = string
}

variable "template" {
  description = "Name of VM template to clone from"
  type        = string
}

variable "gateway" {
  description = "IPv4 gateway address for the VMs"
  type        = string
}
