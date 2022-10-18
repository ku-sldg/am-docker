#!/bin/bash -xe

AT_PREFIX="${AT_PREFIX:-}"
OUT="$(cat ${AT_PREFIX}/truffle-compile.out | ${AT_PREFIX}/scripts/truffle-parse-contract-addresses.py)"

CM_ADDR="$(echo $OUT | cut -d' ' -f1)"
HR_ADDR="$(echo $OUT | cut -d' ' -f2)"

echo -n "$CM_ADDR" > "${AT_PREFIX}/ku-mst/pnet/credential-manager.address"
echo -n "$HR_ADDR" > "${AT_PREFIX}/ku-mst/pnet/health-records.address"

