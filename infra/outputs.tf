output "master_node_ip" {
  value = digitalocean_droplet.master_node.ipv4_address
}

output "controller_node1_ip" {
  value = digitalocean_droplet.controller_node1.ipv4_address
}

output "controller_node2_ip" {
  value = digitalocean_droplet.controller_node2.ipv4_address
}