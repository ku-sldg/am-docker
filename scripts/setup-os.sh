#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive
AT_PREFIX="${AT_PREFIX:-}"

if ! [ -d "${AT_PREFIX}/scripts" ]; then
    cp -r ./scripts "${AT_PREFIX}/scripts"
fi

"${AT_PREFIX}/scripts/setup-services.sh"

if which git && which cmake && which git && which node && which npm && which ethereum ; then
    exit 0
fi

if which apt; then
    PREFSUDO=""
    if which sudo; then
        PREFSUDO="sudo"
    fi

    ${PREFSUDO} apt update

    ${PREFSUDO} ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
    ${PREFSUDO} apt-get install -y tzdata
    ${PREFSUDO} dpkg-reconfigure --frontend noninteractive tzdata

    ${PREFSUDO} apt install -y wget tar build-essential cmake openssl libssl-dev vim git software-properties-common expect nodejs npm

    ${PREFSUDO} add-apt-repository -y ppa:ethereum/ethereum
    ${PREFSUDO} apt update
    ${PREFSUDO} apt install -y ethereum
else

    echo "Not running in an apt environment!"
    exit 1

fi

