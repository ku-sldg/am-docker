#!/bin/bash -xe

AT_PREFIX="${AT_PREFIX:-}"
cd "${AT_PREFIX}/ku-mst/pnet/node1/geth/truffle"

BLK_HTTP_PORT="${BLK_HTTP_PORT:-8543}"
BLK_NETWORK_ID="${BLK_NETWORK_ID:-4321}"

cp ../../../../src/smartcontracts/goldenHashManager/HealthRecords.sol contracts
cp ../../../../src/smartcontracts/goldenHashManager/credentialManager.sol contracts

cat >> migrations/2_deploy_contracts.js <<EOF
const cm = artifacts.require("./credentialManager.sol");
const hr = artifacts.require("./HealthRecords.sol");
module.exports = function(deployer) {
    deployer.deploy(cm);
    deployer.deploy(hr);
};
EOF

ACCT_ID="0x$(cat ${AT_PREFIX}/ku-mst/pnet/geth-public-address.out)"

cat > truffle-config.js <<EOF
module.exports = {
    networks: {
    development: {
	host: "127.0.0.1",
	port: ${BLK_HTTP_PORT},
	network_id: "${BLK_NETWORK_ID}",
	from: "${ACCT_ID}",
	gas: 0,
    },
  },

  mocha: {
  },

  rpc: {
    host: "127.0.0.1",
    port: ${BLK_HTTP_PORT},
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.0" // Fetch exact version from solc-bin (default: truffle's version)
    }
  }
};
EOF

