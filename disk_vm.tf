resource "yandex_compute_disk" "storage" {
  count = 3

  name = "disk-${count.index + 1}"
  size = 1
  type = "network-hdd"
  zone = "ru-central1-d"
}

resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v3"

  resources {
    cores         = var.storage_cores
    memory        = var.storage_memory
    core_fraction = var.storage_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id    = data.yandex_compute_image.ubuntu.id
      type        = var.storage_disk_type
      size        = var.storage_disk_size
    }
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage[*].id
    content {
      disk_id = secondary_disk.value
    }
  }

  scheduling_policy {
    preemptible = var.storage_preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = var.storage_nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${local.ssh_public_key}"
  }
}