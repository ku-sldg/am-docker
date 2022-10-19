#!/bin/bash -e

ARCHIVE_PATH="$(realpath ibmtpm1682.tar.gz)"
AT_PREFIX="${AT_PREFIX:-}"

mkdir "${AT_PREFIX}/tpm"
cd "${AT_PREFIX}/tpm"

tar xzf "${ARCHIVE_PATH}"

cd src
make
mkdir -p "${AT_PREFIX}/usr/bin"
cp tpm_server "${AT_PREFIX}/usr/bin/tpm_server"

cd "${AT_PREFIX}/"
rm -rf "${AT_PREFIX}/tpm"

