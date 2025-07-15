# Terraform script to deploy CMMS On-Prem infrastructure on VMware (using vsphere provider)
# Assumes you have a vSphere cluster available

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  allow_unverified_ssl = true
}

# Data sources for vSphere

data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.template
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Create VMs for each role in CMMS infrastructure
resource "vsphere_virtual_machine" "cmms_vm" {
  for_each = var.cmms_servers

  name             = each.key
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = each.value.cpu
  memory   = each.value.memory
  guest_id = data.vsphere_virtual_machine.template.guest_id

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = each.value.disk
    eagerly_scrub    = false
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = each.key
        domain    = "local"
      }

      network_interface {
        ipv4_address = each.value.ip
        ipv4_netmask = 24
      }

      ipv4_gateway = var.gateway
    }
  }
}

# Variables for servers
variable "cmms_servers" {
  type = map(object({
    cpu    = number
    memory = number
    disk   = number
    ip     = string
  }))
  default = {
    "app-server-1" = { cpu = 4, memory = 32768, disk = 1024, ip = "192.168.10.11" },
    "app-server-2" = { cpu = 4, memory = 32768, disk = 1024, ip = "192.168.10.12" },
    "db-server-1"  = { cpu = 4, memory = 32768, disk = 2048, ip = "192.168.10.21" },
    "db-server-2"  = { cpu = 4, memory = 32768, disk = 2048, ip = "192.168.10.22" },
    "file-server"  = { cpu = 2, memory = 16384, disk = 2048, ip = "192.168.10.31" },
    "backup-server"= { cpu = 2, memory = 16384, disk = 2048, ip = "192.168.10.41" },
    "ci-cd-server" = { cpu = 2, memory = 16384, disk = 1024, ip = "192.168.10.51" }
  }
}

# Other required variables
variable "vsphere_user" {}
variable "vsphere_password" {}
variable "vsphere_server" {}
variable "datacenter" {}
variable "datastore" {}
variable "cluster" {}
variable "network" {}
variable "template" {}
variable "gateway" {}

