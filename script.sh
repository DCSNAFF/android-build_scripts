#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/neonred226/manifest_derp.git -b 15.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/BaranAspect-Development/android-rom-build -b derp-15.2 .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# build
/opt/crave/resync.sh
echo "============="
echo "Sync success"
echo "============="

rm -rf hardware/qcom-caf/msm8996 \
       hardware/qcom-caf/msm8998 \
       hardware/qcom-caf/sdm845 \
       hardware/qcom-caf/sm8150 \
       hardware/qcom-caf/sm8250 \
       hardware/qcom-caf/sm8350 \
       hardware/qcom-caf/sm8450 \
       hardware/qcom-caf/sm8550
       
echo "==========================="
echo "Unnecessary dirs removed"
echo "==========================="

# Export
export BUILD_USERNAME=NEONXD
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

# initiate build setup
. build/envsetup.sh


echo "======= Export Done ======"
lunch lineage_topaz-bp1a-userdebug && mka derp
