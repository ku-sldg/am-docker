#!/bin/bash -e

AT_PREFIX="${AT_PREFIX:-}"
RELDIR="$(cd -- $(dirname -- ${BASH_SOURCE[0]}) &> /dev/null && pwd)"

# Install OS-level dependencies
"${RELDIR}/setup-os.sh"

# Copy, build, and install the IBM TPM 2.0 server
"${RELDIR}/setup-tpm.sh"

# Download, build, and install the CakeML compiler
"${RELDIR}/setup-cakeml.sh"

# Download and set up the AM blockchain
"${RELDIR}/scripts/setup-blockchain.sh"

# Download and cmake the CakeML attestation manager
"${RELDIR}/scripts/setup-am-cakeml.sh"

