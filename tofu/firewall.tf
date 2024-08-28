# https://kubernetes.io/docs/reference/networking/ports-and-protocols/

resource "digitalocean_firewall" "kubernetes_controller_firewall" {
  name   = "kubernetes-controller-firewall"
  droplet_ids = [for node in digitalocean_droplet.controller_node : node.id]

  # Kubernetes API server	
  inbound_rule {
    protocol         = "tcp"
    port_range       = "6443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  # etcd server client API
  inbound_rule {
    protocol         = "tcp"
    port_range       = "2379-2380"
    source_addresses = local.all_ips

  }
  # Kubelet API,  kube-scheduler, kube-controller-manager
  inbound_rule {
    protocol         = "tcp"
    port_range       = "10250-10252"
    source_addresses = local.all_ips
  }
  # allow ssh
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  # Allow all outbound traffic
  outbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
   }
}


resource "digitalocean_firewall" "kubernetes_worker_firewall" {
  name   = "kubernetes-worker-firewall"
  droplet_ids = [for node in digitalocean_droplet.worker_node : node.id]

  # Kubernetes API server	
  inbound_rule {
    protocol         = "tcp"
    port_range       = "6443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Kubelet API
  inbound_rule {
    protocol         = "tcp"
    port_range       = "10250"
    source_addresses = local.all_ips
  }
  # NodePort Services
  inbound_rule {
    protocol         = "tcp"
    port_range       = "30000-32767"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  # allow ssh
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
  # Allow all outbound traffic
  outbound_rule {
    protocol         = "tcp"
    port_range       = "all"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

