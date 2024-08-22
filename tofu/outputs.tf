output "master_node_ip" {
  value = digitalocean_droplet.master_node.ipv4_address
}

output "worker_node_ips" {
  description = "The IPv4 addresses of the worker nodes"
  value       = [for worker in digitalocean_droplet.worker_node : worker.ipv4_address]
}