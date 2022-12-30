#!/bin/bash
#
# start the valheim server
#

set -o nounset
set -o errexit

source "$(dirname ${0})/service.properties"

data_path="/var/lib/valheim/${server_name}"
mkdir -p "${data_path}/config"
mkdir -p "${data_path}/data"

podman run -i \
  --cap-add=sys_nice \
  --stop-timeout 120 \
  -p 2456-2457:2456-2457/udp \
  -v ${data_path}/config:/config \
  -v ${data_path}/data:/opt/valheim \
  -e SERVER_NAME="${server_name}" \
  -e WORLD_NAME="${server_name}" \
  -e SERVER_PASS="${server_password}" \
  -e RESTART_CRON="0 10 * * *" \
  -e SERVER_PUBLIC=false \
  docker.io/lloesche/valheim-server:latest
