locals {  
  all_nodes = flatten([
    digitalocean_droplet.controller_node,
    digitalocean_droplet.worker_node,
  ]) 

  all_firewalls = flatten([   
    digitalocean_firewall.kubernetes_controller_firewall,
    digitalocean_firewall.kubernetes_worker_firewall,
  ])

  k0s_provisioner_requirements =  flatten([
    local.all_nodes,
    local.all_firewalls,
  ])

  all_ips = [for node in local.all_nodes : node.ipv4_address]

  controllers_count = length(digitalocean_droplet.controller_node)
}
