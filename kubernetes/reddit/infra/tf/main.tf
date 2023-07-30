terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.95.0"
    }
  }
}


provider "yandex" {
  zone = var.zone
  //service_account_key_file = var.service_account_key_file
}

resource "yandex_compute_instance" "worker" {
  name        = "worker"
  platform_id = "standard-v1"
  resources {
    cores         = 4
    memory        = 4
    core_fraction = 100
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 40
      type     = "network-ssd"
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  scheduling_policy {
    preemptible = true
  }

  allow_stopping_for_update = true

  labels = {
    label = "k8s-worker"
    type  = "k8s"
  }
}
resource "yandex_compute_instance" "master" {
  name        = "master"
  platform_id = "standard-v1"
  resources {
    cores         = 4
    memory        = 4
    core_fraction = 100
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 40
      type     = "network-ssd"
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
  scheduling_policy {
    preemptible = true
  }

  allow_stopping_for_update = true

  labels = {
    label = "k8s-master"
    type  = "k8s"
  }
}
