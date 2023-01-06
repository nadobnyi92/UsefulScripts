#!/bin/bash

readonly mok_dir='/var/lib/shim-signed/mok'
readonly key="${mok_dir}/MOK.priv"
readonly x509="${mok_dir}/MOK.der"

mkdir -p "${mok_dir}"
openssl req -nodes -new -x509 -newkey rsa:2048 -outform DER -addext "extendedKeyUsage=codeSigning" -keyout "${key}" -out "${x509}"
mokutil --import "${x509}"
reboot
