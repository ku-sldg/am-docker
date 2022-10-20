#!/bin/bash -e
# `source` this file

RELDIR="$(realpath $(dirname ${BASH_SOURCE[0]}))"

export AT_PREFIX="${HOME}/at-demo"
mkdir -p "$AT_PREFIX"

export BLK_PORT=3001
export BLK_HTTP_PORT=8544
export DEMO_SERVER_PORT=5001

source "${RELDIR}/daymon.sh"

