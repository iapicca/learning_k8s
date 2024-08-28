output "controller_node_ips" {
  description = "The IPv4 addresses of the controller nodes"
  value       = [for node in digitalocean_droplet.controller_node : node.ipv4_address]
}

output "worker_node_ips" {
  description = "The IPv4 addresses of the worker nodes"
  value       = [for node in digitalocean_droplet.worker_node : node.ipv4_address]
}