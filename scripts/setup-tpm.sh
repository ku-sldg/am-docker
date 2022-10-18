#!/bin/bash -e

ARCHIVE_PATH="$(realpath ibmtpm1682.tar.gz)"
AT_PREFIX="${AT_PREFIX:-}"

mkdir "${AT_PREFIX}/tpm"
cd "${AT_PREFIX}/tpm"

tar xzf "${ARCHIVE_PATH}"

cd src
make
cp tpm_server /usr/bin/tpm_server

cd "${AT_PREFIX}/"
rm -rf "${AT_PREFIX}/tpm"

