#!/bin/bash

readonly hash_algo='sha256'
readonly mok_dir='/var/lib/shim-signed/mok'
readonly key="${mok_dir}/MOK.priv"
readonly x509="${mok_dir}/MOK.der"

readonly name="$(basename $0)"
readonly esc='\\e'
readonly reset="${esc}[0m"

green() { local string="${1}"; echo -e "${esc}[32m${string}${reset}"; }
blue() { local string="${1}"; echo -e "${esc}[34m${string}${reset}"; }
log() { local string="${1}"; echo -e "[$(blue $name)] ${string}"; }

# The exact location of `sign-file` might vary depending on your platform.
alias sign-file="/usr/src/kernels/$(uname -r)/scripts/sign-file"

[ -z "${KBUILD_SIGN_PIN}" ] && read -p "Passphrase for ${key}: " KBUILD_SIGN_PIN
export KBUILD_SIGN_PIN

for module in $(dirname $(modinfo -n vboxdrv))/*.ko; do
  log "Signing $(green ${module})..."
  sign-file "${hash_algo}" "${key}" "${x509}" "${module}"
done
