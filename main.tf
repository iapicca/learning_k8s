terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
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

resource "digitalocean_droplet" "master_node" {
  name               = "master-node"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = [digitalocean_ssh_key.ssh_public_key.fingerprint]
  backups            = false
  ipv6               = true

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(digitalocean_public_key_location)
    host        = self.ipv4_address
  }
}

resource "digitalocean_droplet" "controller_node1" {
  name               = "controller-node1"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = [digitalocean_ssh_key.ssh_public_key.fingerprint]
  backups            = false
  ipv6               = true
  
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(digitalocean_public_key_location)
    host        = self.ipv4_address
  }
}

resource "digitalocean_droplet" "controller_node2" {
  name               = "controller-node2"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = [digitalocean_ssh_key.ssh_public_key.fingerprint]
  backups            = false
  ipv6               = true

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(digitalocean_public_key_location)
    host        = self.ipv4_address
  }
}

output "master_node_ip" {
  value = digitalocean_droplet.master_node.ipv4_address
}

output "controller_node1_ip" {
  value = digitalocean_droplet.controller_node1.ipv4_address
}

output "controller_node2_ip" {
  value = digitalocean_droplet.controller_node2.ipv4_address
}