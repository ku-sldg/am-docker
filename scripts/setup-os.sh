#!/bin/bash -e

export DEBIAN_FRONTEND=noninteractive
AT_PREFIX="${AT_PREFIX:-}"

if ! [ -d "${AT_PREFIX}/scripts" ]; then
    cp -r ./scripts "${AT_PREFIX}/scripts"
fi

"${AT_PREFIX}/scripts/setup-services.sh"

if [ -x "$(command -v which)" ] && which git && which cmake && which node && which npm && which geth ; then
    exit 0
fi

PREFSUDO=""
if [ -x "$(command -v sudo)" ]; then
    PREFSUDO="sudo"
fi

if [ -x "$(command -v apt)" ]; then
    ${PREFSUDO} apt update

    ${PREFSUDO} ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
    ${PREFSUDO} apt-get install -y tzdata
    ${PREFSUDO} dpkg-reconfigure --frontend noninteractive tzdata

    ${PREFSUDO} apt install -y wget tar build-essential cmake openssl libssl-dev vim git software-properties-common expect nodejs npm

    ${PREFSUDO} add-apt-repository -y ppa:ethereum/ethereum
    ${PREFSUDO} apt update
    ${PREFSUDO} apt install -y ethereum
elif [ -x "$(command -v dnf)" ]; then

    ${PREFSUDO} dnf install -y wget tar cmake gcc gcc-c++ which cmake openssl openssl-devel expect nodejs npm golang

    mkdir -p $HOME/go
    echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
    echo 'export PATH="$HOME/go/bin:${PATH}"' >> $HOME/.bashrc
    source $HOME/.bashrc
    go install github.com/ethereum/go-ethereum/cmd/geth@latest
    go install github.com/ethereum/go-ethereum/cmd/puppeth@latest

else

    echo "Not running in an apt or dnf environment!"
    exit 1

fi

