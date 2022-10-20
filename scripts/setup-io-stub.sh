#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
ACCT_ID="$(cat ${AT_PREFIX}/ku-mst/pnet/geth-public-address.out)"
HEALTH_ID="$(cat ${AT_PREFIX}/ku-mst/pnet/health-records.address)"
BLK_HTTP_PORT="${BLK_HTTP_PORT:-8543}"
DEMO_SERVER_PORT="${DEMO_SERVER_PORT:-5000}"
DEMO_SERVER_ADDR="${DEMO_SERVER_ADDR:-127.0.0.1}"

sed -i "s/val\suserAddress\s=\s\".*\"/val userAddress = \"0x$ACCT_ID\"/g" "${AT_PREFIX}/am-cakeml/stubs/IO_Stubs_extra.sml"
sed -i "s/val\shealthRecordContract\s=\s\".*\"/val healthRecordContract = \"$HEALTH_ID\"/g" "${AT_PREFIX}/am-cakeml/stubs/IO_Stubs_extra.sml"
sed -i "s/val\sblockchainIpPort\s=\s.*/val blockchainIpPort = ${BLK_HTTP_PORT}/g" "${AT_PREFIX}/am-cakeml/stubs/IO_Stubs_extra.sml"

sed -i "s/8543/${BLK_HTTP_PORT}/g" "${AT_PREFIX}/am-cakeml/apps/blockchain/config.ini"
sed -i "s/8543/${BLK_HTTP_PORT}/g" "${AT_PREFIX}/am-cakeml/apps/blockchain/Blockchain.sml"
sed -i "s/8543/${BLK_HTTP_PORT}/g" "${AT_PREFIX}/am-cakeml/util/Http.sml"

sed -i "s/port\s=\s5000/port = ${DEMO_SERVER_PORT}/g" "${AT_PREFIX}/am-cakeml/apps/demo/server/example_server.ini"
sed -i "s/=>\s5000/=> ${DEMO_SERVER_PORT}/g" "${AT_PREFIX}/am-cakeml/am/CoplandCommUtil.sml"

sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/blockchain/Blockchain.sml"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/blockchain/CAClient.sml"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/blockchain/config.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/serverClient/example_server_two.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/serverClient/example_server.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/serverClient/example_client.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/demo/client/example_client_badkey.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/demo/client/example_client_goodkey.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/demo/client/example_client.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/demo/server/example_server.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/apps/demo/server/example_server_two.ini"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/util/Http.sml"
sed -i "s/127.0.0.1/${DEMO_SERVER_ADDR}/g" "${AT_PREFIX}/am-cakeml/stubs/IO_Stubs_extra.sml"

