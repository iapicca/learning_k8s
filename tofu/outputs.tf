output "master_node_ip" {
  value = digitalocean_droplet.master_node.ipv4_address
}

output "worker_node_1_ip" {
  value = digitalocean_droplet.worker_node_1.ipv4_address
}

output "worker_node_2_ip" {
  value = digitalocean_droplet.worker_node_2.ipv4_address
}