terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
  }
}

provider "docker" {}

# Загрузка образа Ubuntu
resource "docker_image" "ubuntu" {
  name         = "ubuntu:22.04"
  keep_locally = true
}

# Создание трех серверов
resource "docker_container" "nodes" {
  count = 3

  name  = "node-${count.index + 1}"
  image = docker_image.ubuntu.image_id

  command = ["tail", "-f", "/dev/null"]
}