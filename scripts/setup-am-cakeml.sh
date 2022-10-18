#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
cd "${AT_PREFIX}/"

git clone --branch tpm-dev https://github.com/ku-sldg/am-cakeml
cd am-cakeml
mkdir build && cd build
cmake ..
cp "${AT_PREFIX}/am-cakeml/apps/demo/server/src-data.txt" "${AT_PREFIX}/am-cakeml/build/apps/demo/"

"${AT_PREFIX}/scripts/setup-io-stub.sh"

make demo

