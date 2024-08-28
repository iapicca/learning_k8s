resource "null_resource" "k0s_provisioner" {
  depends_on =  [local.k0s_provisioner_requirements]
    
  provisioner "local-exec" {
    environment = {
      SSH = "${data.local_file.ssh_private_key_file.filename}"
      IPS = "${join(" ", local.all_ips)}"
      CTRL_COUNT = "${local.controllers_count}"
    }

    command = "k0sctl init -i $SSH -C $CTRL_COUNT $IPS > k0sctl.yaml"
  }

  provisioner "local-exec" {
    command = "k0sctl apply --config k0sctl.yaml > ../.kube/config.yaml"
  }
}