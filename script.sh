#!/bin/bash

rm -rf .repo/local_manifests/

# repo init rom
repo init -u https://github.com/Masood-J/android_lineage.git -b lineage-22.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Local manifests
git clone https://github.com/Topaz-Labs/rom-build.git -b test .repo/local_manifests
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
export BUILD_USERNAME=TeamAspectPower
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

FSGEN_BP="build/soong/fsgen/Android.bp"

# Check if patch is already applied
if ! grep -q 'enabled: false' "$FSGEN_BP"; then
    echo "Applying custom patch for fsgen..."
    sed -i '/soong_filesystem_creator {/a\    enabled: false,' "$FSGEN_BP"
    echo "Patch applied successfully"
else
    echo "Patch already applied. Skipping..."
fi

# initiate build setup
. build/envsetup.sh



echo "======= Export Done ======"
lunch lineage_topaz-bp1a-userdebug && mka bacon 
