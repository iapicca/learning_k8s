data "local_file" "ssh_public_key_file" {
  filename = "/Users/francesco/.ssh/do_ssh_key.pub"
}

data "local_file" "ssh_private_key_file" {
  filename = "/Users/francesco/.ssh/do_ssh_key"
}

