terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api.url
  pm_api_token_id     = var.proxmox_api.token_id
  pm_api_token_secret = var.proxmox_api.token_secret
}


resource "proxmox_vm_qemu" "k8s-control-planes" {
  # K8s Informations
  for_each    = var.control-planes
  vmid        = each.value["vmid"]
  name        = each.value["name"]
  desc        = each.value["desc"]
  target_node = each.value["target_node"]
  agent       = 1

  # K8s Clone Configuration
  clone      = "k8s-docker-base"
  full_clone = true

  # K8s Resources
  cores   = 4
  sockets = 1
  cpu     = "kvm64"
  memory  = 4048

  # Cloud Init Configuration
  ipconfig0  = each.value["ipconfig0"]
  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys

  # K8s SSH Configuration
  ssh_user = var.ciuser

  # K8s Network Configuration
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  # K8s Disk Configuration
  disk {
    storage = "local-lvm"
    type    = "scsi"
    size    = "10G"
  }  
}


resource "proxmox_vm_qemu" "k8s-workers" {
  # K8s Informations
  for_each    = var.workers
  vmid        = each.value["vmid"]
  name        = each.value["name"]
  desc        = each.value["desc"]
  target_node = each.value["target_node"]
  agent       = 1

  # K8s Clone Configuration
  clone      = "k8s-docker-base"
  full_clone = true

  # K8s Resources
  cores   = 4
  sockets = 1
  cpu     = "kvm64"
  memory  = 8192

  # Cloud Init Configuration
  ipconfig0  = each.value["ipconfig0"]
  ciuser     = var.ciuser
  cipassword = var.cipassword
  sshkeys = var.sshkeys

  # K8s SSH Configuration
  ssh_user = var.ciuser

  # K8s Network Configuration
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  # K8s Disk Configuration
  disk {
    storage = "local-lvm"
    type    = "scsi"
    size    = "50G"
  }  
}

