# vSphere Credentials
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

# Infrastructure Configuration
variable "datacenter" {
  description = "Name of the vSphere datacenter"
  type        = string
}

variable "datastore" {
  description = "Name of the datastore to use"
  type        = string
}

variable "cluster" {
  description = "Name of the vSphere compute cluster"
  type        = string
}

variable "network" {
  description = "Name of the VM network"
  type        = string
}

variable "template" {
  description = "Name of the template VM to clone from"
  type        = string
}

variable "gateway" {
  description = "IPv4 gateway for the VM network"
  type        = string
}

# VM Definitions
variable "cmms_servers" {
  description = "Definition of CMMS virtual machines"
  type = map(object({
    cpu    = number
    memory = number
    disk   = number
    ip     = string
  }))
}

