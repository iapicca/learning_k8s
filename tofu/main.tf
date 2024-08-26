terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_ssh_key" "ssh_public_key" {
  name       = "digitalocean_public_key"
  public_key = file("/Users/francesco/.ssh/do_ssh_key.pub")
}

data "docker_registry_image" "k0s" {
  name = "k0sproject/k0s:latest"
}

resource "docker_image" "controller_node_image" {
  name = data.docker_registry_image.k0s.name
  build {
    path = "."
    tag  = ["zoo:develop"]
    build_arg = {
      foo : "zoo"
    }
    label = {
      author : "zoo"
    }
  }
}

resource "digitalocean_droplet" "controller_node" {
  count  = 1
  name               = "controller-node-${count.index}"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = docker_image.controller_node_image
  ssh_keys           = [digitalocean_ssh_key.ssh_public_key.fingerprint]
  backups            = false
  ipv6               = true

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("/Users/francesco/.ssh/do_ssh_key")
    host        = self.ipv4_address
  }
}

resource "digitalocean_droplet" "worker_node" {
  count  = 2
  name               = "worker-node-${count.index}"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = [digitalocean_ssh_key.ssh_public_key.fingerprint]
  backups            = false
  ipv6               = true
  
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("/Users/francesco/.ssh/do_ssh_key")
    host        = self.ipv4_address
  }
}
