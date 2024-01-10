#!/bin/bash

PARENT_DIR=${PWD}

CONF_DIR="build/conf"
CONF_FILE_LOCAL="${CONF_DIR}/local.conf"
CONF_FILE_BBLAYERS="${CONF_DIR}/bblayers.conf"

generate_common_bblayers()
{
    cat >> ${CONF_FILE_BBLAYERS} <<EOF
POKY_BBLAYERS_CONF_VERSION = "2"

BBPATH = "\${TOPDIR}"
BBFILES ?= ""

export BSPDIR := "${PWD}"

BBLAYERS = " \\
   \${TOPDIR}/../sources/poky/meta \
   \${TOPDIR}/../sources/poky/meta-poky \
   \${TOPDIR}/../sources/poky/meta-yocto-bsp \
"
EOF
}

rm -rf ${CONF_DIR}
mkdir -p ${CONF_DIR}

################################################################################
# Set Up Config
################################################################################

rm -f ${CONF_FILE_BBLAYERS}
echo '' > ${CONF_FILE_LOCAL}

# Add confiugration lines here
echo 'LICENSE_FLAGS_ACCEPTED = "synaptics-killswitch"' >> ${CONF_FILE_LOCAL}


################################################################################
# Set Up Meta Layers
################################################################################

rm -f ${CONF_FILE_BBLAYERS}
echo '' > ${CONF_FILE_BBLAYERS}

generate_common_bblayers

# Add BBLAYER append lines here
echo "" >> ${CONF_FILE_BBLAYERS}
echo "BBLAYERS += \"\${TOPDIR}/../sources/meta-openembedded/meta-python \"" >> ${CONF_FILE_BBLAYERS}
echo "BBLAYERS += \"\${TOPDIR}/../sources/meta-openembedded/meta-networking \"" >> ${CONF_FILE_BBLAYERS}
echo "BBLAYERS += \"\${TOPDIR}/../sources/meta-openembedded/meta-filesystems \"" >> ${CONF_FILE_BBLAYERS}
echo "BBLAYERS += \"\${TOPDIR}/../sources/meta-openembedded/meta-oe \"" >> ${CONF_FILE_BBLAYERS}
echo "BBLAYERS += \"\${TOPDIR}/../sources/meta-virtualization \"" >> ${CONF_FILE_BBLAYERS}
echo "BBLAYERS += \"\${TOPDIR}/../sources/meta-intel \"" >> ${CONF_FILE_BBLAYERS}
echo "BBLAYERS += \"\${TOPDIR}/../sources/meta-up-board \"" >> ${CONF_FILE_BBLAYERS}

# Add BBMASK append lines here


################################################################################
# Perform Build
################################################################################

pushd .

# Set up environment
. ./sources/poky/oe-init-build-env

# Do the build
MACHINE=up-squared-6000 bitbake upboard-image-base

popd


################################################################################
# Set up Artifacts
################################################################################

rm -rf artifacts
mkdir -p artifacts

cp ./build/tmp-glibc/deploy/images/up-squared-6000/upboard-image-base-up-squared-6000.hddimg artifacts