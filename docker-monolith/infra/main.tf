terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.90.0"
    }
  }
}

variable "machine_count" {
  default = 1
}

resource "yandex_compute_instance" "reddit" {
  name        = "reddit"
  count       = var.machine_count
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8v80pep5m9p7fnp0sd"
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    ssh-keys = "${file("~/.ssh/id_rsa.pub")}"
  }
}
