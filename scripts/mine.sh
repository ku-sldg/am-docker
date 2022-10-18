#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
cd "${AT_PREFIX}/ku-mst/pnet"

expect "${AT_PREFIX}/scripts/mine.exp"

