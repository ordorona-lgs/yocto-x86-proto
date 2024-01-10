#!/bin/bash

if [ ! -d sources ]; then
    echo "Creating sources directory"
    mkdir sources
fi

pushd sources

if [ ! -d meta-intel ]; then
    echo "Cloning meta-intel"
    git clone -b dunfell git://git.yoctoproject.org/meta-intel.git
fi

if [ ! -d meta-openembedded ]; then
    echo "Cloning meta-openembedded"
    git clone -b dunfell git://git.openembedded.org/meta-openembedded.git
fi

if [ ! -d meta-up-board ]; then
    echo "Cloning meta-up-board"
    git clone -b dunfell https://github.com/AaeonCM/meta-up-board.git
fi

if [ ! -d meta-virtualization ]; then
    echo "Cloning meta-virtualization"
    git clone -b dunfell git://git.yoctoproject.org/meta-virtualization.git
fi

if [ ! -d poky ]; then
    echo "Cloning poky"
    git clone -b dunfell git://git.yoctoproject.org/poky.git
fi

popd

if [ ! -f patches/.upboard-image-base ]; then
    echo "Patching Up Board build"
    patch -d sources/meta-up-board/ -p1 < patches/upboard-image-base.patch
    if [[ $? -eq 0 ]]; then 
        touch patches/.upboard-image-base
    fi 
fi
