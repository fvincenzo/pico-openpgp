#!/usr/bin/env bash

while getopts ":p:v:" opt; do
  case ${opt} in
    p ) PLATFORM=$OPTARG;;
    v ) VERSION=$OPTARG;;
    \? ) echo "Usage: build_picox_openpgp.sh [-p] [-v]";;
  esac
done

export PICO_OPENPGP_BUILD="$(pwd)/build"
export PICO_OPENPGP_PLATFORM=$PLATFORM
export PICO_OPENPGP_VERSION=$VERSION

git submodule update --init --recursive

if [ -d "$PICO_OPENPGP_BUILD" ]; then
    rm -fr $PICO_OPENPGP_BUILD
fi

mkdir $PICO_OPENPGP_BUILD && cd $PICO_OPENPGP_BUILD

export PICO_SDK_PATH=../../pico-sdk

#cmake .. -DPICO_BOARD=pico -DUSB_VID=0x1234 -DUSB_PID=0x5678
cmake .. -DPICO_BOARD=$PICO_OPENPGP_PLATFORM

make -kj16

cp pico_openpgp.uf2 pico_openpgp_$PICO_OPENPGP_PLATFORM-$PICO_OPENPGP_VERSION.uf2
