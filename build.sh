#!/bin/sh

# Requires:
# autoconf
# automake
# libtool
# uuid-dev
# libaio-dev

blktap_repo='git@github.com:comstud/blktap'
branch='add_vhd2raw'

if [ ! -d blktap.git ] ; then
    git clone ${blktap_repo} blktap.git
    if [ $? -ne 0 ] ; then
        echo "Error: Couldn't clone ${blktap_repo}."
        exit 1
    fi
fi

cd blktap.git || exit 1
git checkout ${branch} || exit 1

if [ ! -f vhd/Makefile ] ; then
    ./autogen.sh &&
    ./configure
    if [ $? -ne 0 ] ; then
        echo 'Error: configure failed.'
        exit 1
    fi
fi

cd vhd && make
if [ $? -ne 0 ] ; then
    echo 'Error: Build failed.'
    exit 1
fi
