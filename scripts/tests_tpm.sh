#!/bin/bash -xe

AT_PREFIX="${AT_PREFIX:-}"
cd "${AT_PREFIX}/am-cakeml/build"

make tests_tpm

cd ../apps/tests

../../build/apps/tests/tests_tpm

