resource "null_resource" "provisioner" {
  triggers {
    user        = "${var.connection_user}"
    host        = "${var.connection_host}"
    private_key = "${sha1("${var.connection_private_key}")}"
    port        = "${var.connection_port}"
  }

  connection {
    user        = "${var.connection_user}"
    host        = "${var.connection_host}"
    private_key = "${var.connection_private_key}"
    port        = "${var.connection_port}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -qq",
      "sudo apt-get install -y aptdaemon",
      "sudo apt-get upgrade -y",
    ]
  }
}
