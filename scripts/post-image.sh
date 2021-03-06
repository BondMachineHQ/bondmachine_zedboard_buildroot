#!/bin/sh

# By default U-Boot loads DTB from a file named "devicetree.dtb", so
# let's use a symlink with that name that points to the *first*
# devicetree listed in the config.

FIRST_DT=$(sed -n \
           's/^BR2_LINUX_KERNEL_INTREE_DTS_NAME="\([a-z0-9\-]*\).*"$/\1/p' \
           ${BR2_CONFIG})

[ -z "${FIRST_DT}" ] || ln -fs ${FIRST_DT}.dtb ${BINARIES_DIR}/devicetree.dtb

cp -a ${BR2_EXTERNAL_BM_ZED_PATH}/bmfiles/bondmachine.bin ${BINARIES_DIR}/
cp -a ${BR2_EXTERNAL_BM_ZED_PATH}/bmfiles/uEnv.txt ${BINARIES_DIR}/

support/scripts/genimage.sh -c ${BR2_EXTERNAL_BM_ZED_PATH}/configs/genimage.cfg
