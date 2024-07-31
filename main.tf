provider "digitalocean" {
  token = var.digitalocean_token
}

resource "digitalocean_droplet" "master_node" {
  name               = "master-node"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = ["SHA256:+yx+g3YiaKGNZOesz0ElXR3pCkAkm3Gx+64Xu9PRONg francesco@Francescos-MacBook-Air.local"]
  backups            = false
  ipv6               = true
}

resource "digitalocean_droplet" "controller_node1" {
  name               = "controller-node1"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = [var.ssh_fingerprint]
  backups            = false
  ipv6               = true
}

resource "digitalocean_droplet" "controller_node2" {
  name               = "controller-node2"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = [var.ssh_fingerprint]
  backups            = false
  ipv6               = true
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