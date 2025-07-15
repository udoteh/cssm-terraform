vsphere_user     = "root"
vsphere_password = "your-secret-password"
vsphere_server   = "192.168.1.87"

datacenter = "Your-Datacenter"
datastore  = "Your-Datastore"
cluster    = "Your-Cluster"
network    = "VM Network"
template   = "ubuntu-template"
gateway    = "192.168.10.1"

cmms_servers = {
  "app-server-1" = { cpu = 4, memory = 32768, disk = 1024, ip = "192.168.1.11" },
  "app-server-2" = { cpu = 4, memory = 32768, disk = 1024, ip = "192.168.1.12" },
  "db-server-1"  = { cpu = 4, memory = 32768, disk = 2048, ip = "192.168.1.21" },
  "db-server-2"  = { cpu = 4, memory = 32768, disk = 2048, ip = "192.168.1.22" },
  "file-server"  = { cpu = 2, memory = 16384, disk = 2048, ip = "192.168.1.31" },
  "backup-server"= { cpu = 2, memory = 16384, disk = 2048, ip = "192.168.1.41" },
  "ci-cd-server" = { cpu = 2, memory = 16384, disk = 1024, ip = "192.168.1.51" }
}

