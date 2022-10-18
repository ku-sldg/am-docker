#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
ACCT_ID="$(cat ${AT_PREFIX}/ku-mst/pnet/geth-public-address.out)"
HEALTH_ID="$(cat ${AT_PREFIX}/ku-mst/pnet/health-records.address)"

sed -i "s/val\suserAddress\s=\s\".*\"/val userAddress = \"0x$ACCT_ID\"/g" "${AT_PREFIX}/am-cakeml/stubs/IO_Stubs_extra.sml"
sed -i "s/val\shealthRecordContract\s=\s\".*\"/val healthRecordContract = \"$HEALTH_ID\"/g" "${AT_PREFIX}/am-cakeml/stubs/IO_Stubs_extra.sml"

