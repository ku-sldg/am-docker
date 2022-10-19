#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
source "${AT_PREFIX}/scripts/daymon.sh"

BLK_PORT="${BLK_PORT:-3000}"
BLK_HTTP_PORT="${BLK_HTTP_PORT:-8543}"
BLK_NETWORK_ID="${BLK_NETWORK_ID:-4321}"

daymon_init

sed -i "s/%%BLK_PORT%%/${BLK_PORT}/g" "${AT_PREFIX}/scripts/mine.exp"
sed -i "s/%%BLK_HTTP_PORT%%/${BLK_HTTP_PORT}/g" "${AT_PREFIX}/scripts/mine.exp"
sed -i "s/%%BLK_NETWORK_ID%%/${BLK_NETWORK_ID}/g" "${AT_PREFIX}/scripts/mine.exp"
daymon_configure mine "bash -c 'cd ${AT_PREFIX}/ku-mst/pnet && expect ${AT_PREFIX}/scripts/mine.exp'"

daymon_configure tpm "${AT_PREFIX}/usr/bin/tpm_server"

daymon_configure demo.server "bash -c 'cd ${AT_PREFIX}/am-cakeml/build/apps/demo && ${AT_PREFIX}/am-cakeml/build/apps/demo/serverdemo ${AT_PREFIX}/am-cakeml/apps/demo/server/example_server.ini'"

daymon_configure demo.serverClient "bash -c 'cd ${AT_PREFIX}/am-cakeml/build/apps/demo && ${AT_PREFIX}/am-cakeml/build/apps/demo/serverdemo ${AT_PREFIX}/am-cakeml/apps/demo/serverClient/example_server.ini'"

