#!/bin/bash -xe

AT_PREFIX="${AT_PREFIX:-}"
cd "${AT_PREFIX}/am-cakeml/build"

make tests

cd ../apps/tests

../../build/apps/tests/tests

