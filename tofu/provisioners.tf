locals {  
  all_nodes = flatten([
    digitalocean_droplet.master_node,
    digitalocean_droplet.worker_node,
  ]) 
}

resource "null_resource" "all_nodes_provisioner" {
  depends_on = [local.all_nodes]
  count = length(local.all_nodes)

  connection {
    type        = "ssh"
    user        = "root"
    private_key = file("/Users/francesco/.ssh/do_ssh_key")
    host        = local.all_nodes[count.index].ipv4_address
  }

  provisioner "file" {
    source      = "taskfiles/taskfile.yml"
    destination = "/root/taskfile.yml"
  }

  provisioner "remote-exec" {
    inline = flatten([
      "curl -sL https://taskfile.dev/install.sh | sh",
      "task setup-kubernetes",
      "sudo hostnamectl set-hostname \"${local.all_nodes[count.index].name}\"",
      [for node in  local.all_nodes : "sudo sh -c 'echo \"${node.ipv4_address} ${node.name}\" >> /etc/hosts'"],
    ])
  }
}