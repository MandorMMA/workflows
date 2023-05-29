terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

resource "docker_image" "wordpress" {
  name         = "wordpress:latest"
  keep_locally = false
}

resource "docker_container" "wordpress" {
  image = docker_image.wordpress.image_id
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}
