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
  public_key = data.local_file.ssh_public_key_file.content
}

resource "digitalocean_droplet" "controller_node" {
  count  = 1
  name               = "controller-node-${count.index}"
  region             = "fra1"
  size               = "s-1vcpu-1gb"
  image              = "ubuntu-24-04-x64"
  ssh_keys           = [digitalocean_ssh_key.ssh_public_key.fingerprint]
  backups            = false
  ipv6               = true

  connection {
    type        = "ssh"
    user        = "root"
    private_key = data.local_file.ssh_public_key_file.content
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
    private_key = data.local_file.ssh_private_key_file.content
    host        = self.ipv4_address
  }
}
