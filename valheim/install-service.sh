#!/bin/bash
#
# installation scripts for a systemd service
#

set -o nounset
set -o errexit

# add a service user
rm -r "${module_install_dir}" || true
mkdir -p "${module_install_dir}"
adduser --system --no-create-home --home "${module_install_dir}" "${module_name}" || true
addgroup --system "${module_name}" || true
cp "${module_resource_dir}/${module_name}/service.sh" "${module_install_dir}/service.sh"
chown -R "${module_name}" "${module_install_dir}"

# create the service unit
cat << SVC-UNIT > "/etc/systemd/system/${module_name}.service"
[Unit]
Description=${module_name} server
After=network.target

[Service]
ExecStart=/bin/bash ${module_install_dir}/service.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
SVC-UNIT
systemctl daemon-reload

#systemctl --user restart dbus
systemctl start ${module_name} 
