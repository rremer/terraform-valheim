resource "null_resource" "provisioner" {
  triggers {
    connection_user        = "${var.connection_user}"
    connection_host        = "${var.connection_host}"
    connection_private_key = "${sha1("${var.connection_private_key}")}"
    connection_port        = "${var.connection_port}"
    module_install_basedir = "${var.module_install_basedir}"

    main_tf            = "${sha1("${file("${path.module}/main.tf")}")}"
    variables_tf       = "${sha1("${file("${path.module}/variables.tf")}")}"
    provision_sh       = "${sha1("${file("${path.module}/provision.sh")}")}"
    install_service_sh = "${sha1("${file("${path.module}/install-service.sh")}")}"
    service_sh         = "${sha1("${file("${path.module}/service.sh")}")}"
  }

  connection {
    user        = "${var.connection_user}"
    host        = "${var.connection_host}"
    private_key = "${var.connection_private_key}"
    port        = "${var.connection_port}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkdir -p ${var.module_resource_dir}/${var.module_name}",
      "sudo chown -R ${var.connection_user} ${var.module_resource_dir}/${var.module_name}",
    ]
  }

  provisioner "file" {
    content = <<PROPERTIES
# generated on deployment from ${path.module}

DEBIAN_FRONTEND=noninteractive

# general module properties
module_name='${var.module_name}'
module_resource_dir='${var.module_resource_dir}'
module_install_basedir='${var.module_install_basedir}'
module_install_dir='${var.module_install_basedir}/${var.module_name}'
module_install_log='${var.module_install_log}'

# valheim properties
server_name='${var.server_name}'
server_password='${var.server_password}'
PROPERTIES

    destination = "${var.module_resource_dir}/${var.module_name}/${var.module_properties}"
  }

  provisioner "file" {
    source      = "${path.module}/"
    destination = "${var.module_resource_dir}/${var.module_name}/"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo bash ${var.module_resource_dir}/${var.module_name}/provision.sh ${var.module_properties}",
    ]
  }
}
