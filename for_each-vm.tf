variable "each_vm" {
  description = "Parameters for creating database VMs"
  type = list(object({
    vm_name       = string
    cpu           = number
    ram           = number
    disk_volume   = number
    core_fraction = number
    platform_id   = string
    #image_id      = optional(string, "ubuntu-2004-lts")
    preemptible   = bool
  }))
  default = [
    {
      vm_name       = "main"
      cpu           = 2
      ram           = 2
      disk_volume   = 11
      core_fraction = 20
      platform_id   = "standard-v3"
      preemptible   = true
    },
    {
      vm_name       = "replica"
      cpu           = 2
      ram           = 1
      disk_volume   = 10
      core_fraction = 20
      platform_id   = "standard-v3"
      preemptible   = true
    }
  ]
}

resource "yandex_compute_instance" "db" {
  for_each    = { for vm in var.each_vm : vm.vm_name => vm }
  name        = each.key
  platform_id = each.value.platform_id

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      size     = each.value.disk_volume
    }
  }

  scheduling_policy {
    preemptible = each.value.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}