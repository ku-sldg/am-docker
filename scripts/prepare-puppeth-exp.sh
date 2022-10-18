#!/bin/bash -xe

AT_PREFIX="${AT_PREFIX:-}"
ACTUAL_ID="$(cat ${AT_PREFIX}/ku-mst/pnet/geth-public-address.out)"

sed -i "s/%%ACCT_ID%%/${ACTUAL_ID}/g" "${AT_PREFIX}/scripts/puppeth.exp"

