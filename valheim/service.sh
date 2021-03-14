#!/bin/bash
#
# start the valheim server
#

set -o nounset
set -o errexit

server_name=example
server_pass=changethis123

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
  -e SERVER_PASS="${server_pass}" \
  docker.io/lloesche/valheim-server:latest
