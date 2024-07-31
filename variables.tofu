variable "ssh_fingerprint" {
  description = "The SSH key fingerprint to access the droplets"
  type        = string
  sensitive = true
}

variable "digitalocean_token" {
  description = "The token for my digital ocean project"
  type        = string
  sensitive = true
}