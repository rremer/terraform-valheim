#!/bin/bash
#
# installation scripts for a container runtime
#

set -o nounset
set -o errexit

. /etc/os-release
echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" | sudo tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list
curl -L https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key | sudo apt-key add -
sudo apt-get update

#yes | aptdcon --install podman
sudo apt-get install -y podman containernetworking-plugins fuse-overlayfs
