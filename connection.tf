resource "null_resource" "ssh_public_key" {
  triggers = {
    file_main_tf = sha1(file(var.connection_credentials_path))
  }

  provisioner "local-exec" {
    command = "ssh-keygen -y -f ${var.connection_credentials_path} > ${var.connection_public_credentials_path}"
  }
}

