#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"

# Install OS-level dependencies
"${AT_PREFIX}/scripts/setup-os.sh"

# Copy, build, and install the IBM TPM 2.0 server
"${AT_PREFIX}/scripts/setup-tpm.sh"

# Download, build, and install the CakeML compiler
"${AT_PREFIX}/scripts/setup-cakeml.sh"

# Download and set up the AM blockchain
"${AT_PREFIX}/scripts/setup-blockchain.sh"

# Download and cmake the CakeML attestation manager
"${AT_PREFIX}/scripts/setup-am-cakeml.sh"

