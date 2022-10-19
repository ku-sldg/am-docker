#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
GOPATH="${HOME}/go"
export PATH="$HOME/go/bin:${PATH}"

if ! [ -d "${AT_PREFIX}/ku-mst" ]; then
    cp -r ./ku-mst "${AT_PREFIX}/ku-mst"
fi

cd "${AT_PREFIX}/ku-mst"

mkdir -p pnet/node1
cd pnet

echo 'blockchain' > password
geth --datadir node1 account new --password password > geth-account-new.out

cat geth-account-new.out | "${AT_PREFIX}/scripts/geth-parse-public-address.py" > geth-public-address.out
cat geth-account-new.out | "${AT_PREFIX}/scripts/geth-parse-secret-key-file.py" > geth-private-key-file.out

rm -f geth-account-new.out


# Build an input file that automatically submits prompts to puppeth
bash -xe "${AT_PREFIX}/scripts/prepare-puppeth-exp.sh"

cd "${AT_PREFIX}/ku-mst/pnet"
expect "${AT_PREFIX}/scripts/puppeth.exp"
rm -f "${AT_PREFIX}/scripts/puppeth.exp" "${AT_PREFIX}/scripts/prepare-puppeth-exp.sh"

geth --datadir node1 init pnet.json


# Setup the smart contracts
cd "${AT_PREFIX}/ku-mst/pnet"

if ! which truffle ; then
    npm install -g truffle
fi

mkdir node1/geth/truffle
cd node1/geth/truffle
truffle init

"${AT_PREFIX}/scripts/truffle-setup.sh"
"${AT_PREFIX}/scripts/truffle-compile.sh"
"${AT_PREFIX}/scripts/truffle-parse-contract-addresses.sh"

