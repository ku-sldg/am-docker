#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
cd "${AT_PREFIX}/"

if which cake; then
    exit 0
fi

wget https://github.com/CakeML/cakeml/releases/download/v1322/cake-x64-64.tar.gz
tar xzf cake-x64-64.tar.gz

cd cake-x64-64
make cake
cp cake /usr/bin

cd ..
rm -rf cake-x64-64 cake-x64-64.tar.gz

