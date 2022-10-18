#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
source "${AT_PREFIX}/scripts/daymon.sh"

daymon_start mine

cd "${AT_PREFIX}/ku-mst/pnet/node1/geth/truffle"

truffle compile

truffle migrate -f 2 > "${AT_PREFIX}/truffle-compile.out"

daymon_stop mine

