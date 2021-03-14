#!/bin/bash
#
# provisioning script for a minecraft server
#

set -o allexport
set -o errexit
set -o nounset
set -o pipefail

# accept all script-relative paths and exit out to executor path when done
lwd="$(pwd)"
trap on_exit EXIT
on_exit(){
  cd "${lwd}"
}
cd "$(dirname ${0})"

# assert application properties exist and source them
test -f "${1}"
source "${1}"

scripts=(install-container-runtime.sh \
install-service.sh)

# iterate through all the scripts
for script in "${scripts[@]}"; do
  # assert the listed script exists and is syntactically valid
  test -f "${script}"
  bash -n "${script}"

  # run the script and overwrite an installation log
  bash -x "${script}" &>> "${module_install_log}"
  echo "${script}: SUCCESS @$(date +%s)" >> "${module_install_log}"
done
