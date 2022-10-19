#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
source "${AT_PREFIX}/scripts/daymon.sh"

daymon_init

daymon_configure mine "bash -c 'cd ${AT_PREFIX}/ku-mst/pnet && expect ${AT_PREFIX}/scripts/mine.exp'"

daymon_configure tpm "${AT_PREFIX}/usr/bin/tpm_server"

daymon_configure demo.server "bash -c 'cd ${AT_PREFIX}/am-cakeml/build/apps/demo && ${AT_PREFIX}/am-cakeml/build/apps/demo/serverdemo ${AT_PREFIX}/am-cakeml/apps/demo/server/example_server.ini'"

daymon_configure demo.serverClient "bash -c 'cd ${AT_PREFIX}/am-cakeml/build/apps/demo && ${AT_PREFIX}/am-cakeml/build/apps/demo/serverdemo ${AT_PREFIX}/am-cakeml/apps/demo/serverClient/example_server.ini'"

