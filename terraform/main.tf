terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
        }
    }
}

#VIA API

# provider "proxmox" {
#     pm_api_url          = "https://<IP_PVE>:8006/api2/json"
#     pm_api_token_id     = "terraform@pam!terraform"
#     pm_api_token_secret = "T3rr4F0rm-G3n3r4t4d-on-PV3"
#     pm_tls_insecure     = true
# }

#Local

provider "proxmox" {
    pm_api_url          = "https://10.1.149.250:8006/api2/json"
    pm_user             = "root@pam"
    pm_password         = "HelpD3sksitesjo"
    pm_tls_insecure     = true
}


# provider "proxmox" {
#     pm_api_url          = "https://10.1.149.250:8006/api2/json"
#     pm_api_token_id     = "terraform@pam!terraform"
#     pm_api_token_secret = "7caa49fb-5efc-47e7-9b7d-6daa50976bc8"
#     pm_tls_insecure     = true
# }






# resource "proxmox_vm_qemu" "vm-instance" {
#      name                = "vm-instance-created-by-terraform"
#      target_node         = "hydra"
#      clone               = "vm-ubuntu-24"
#      full_clone          = true
#      cores               = 4
#      memory              = 4096
#      disk {
#          size            = "20G"
#          type            = "scsi"
#          storage         = "local"
#          discard         = "on"
#      }
#      network {
#          model     = "virtio"
#          bridge    = "vmbr0.149"
#          firewall  = false
#          link_down = false
#      }
# }

resource "proxmox_lxc" "rocky-linux" {
    hostname        = "rocky-by-terraform"
    count           = 3 #Quantidade de Containers a ser criado
    target_node     = "hydra" #nome do server PVE
    ostemplate      = "local:vztmpl/rockylinux-9-default_20240912_amd64.tar.xz" #Template
    cores           = 2
    memory          = 2048 #RAM
    start           = true #Inicia o container quando criado
    password        = "senhaforte"
    network {
        name = "eth0"
        bridge = "vmbr0.149"
    }
    rootfs {
        storage = "local"
        size    = "10G"
    }
}
