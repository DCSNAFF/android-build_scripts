#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/DerpFest-LOS/android_manifest.git -b 15.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/neonred226/android-rom-build -b derp-15.2 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

# Export
export BUILD_USERNAME=NEONXD
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

# initiate build setup
. build/envsetup.sh


echo "======= Export Done ======"
lunch lineage_topaz-bp1a-userdebug && mka derp
