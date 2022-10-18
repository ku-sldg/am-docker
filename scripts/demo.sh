#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
source "${AT_PREFIX}/scripts/daymon.sh"

daymon_start mine
daymon_start tpm
daymon_start demo.server

cd "${AT_PREFIX}/am-cakeml/build/apps/demo"
./clientdemo ../../../apps/demo/client/example_client.ini

