#!/bin/bash

# fix eror
rm -rf prebuilts/clang/host/linux-x86
rm -rf prebuilts/rust

# repo init rom
repo init -u https://github.com/DerpFest-LOS/android_manifest.git -b 15.2 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# sync
/opt/crave/resync.sh || repo sync
echo "==========================="
echo " sync repository success..."
echo "==========================="

# dontol kucai
git clone https://github.com/AbuRider/android_device_xiaomi_earth.git -b Derpfest-15.2 device/xiaomi/earth

git clone https://github.com/mt6768-dev/proprietary_vendor_xiaomi_earth.git -b lineage-22.2 vendor/xiaomi/earth

git clone https://github.com/LineageOS/android_kernel_xiaomi_earth.git -b lineage-22.2 kernel/xiaomi/earth

git clone https://github.com/LineageOS/android_hardware_xiaomi.git -b lineage-22.2 hardware/xiaomi

git clone https://github.com/LineageOS/android_hardware_mediatek.git -b lineage-22.2 hardware/mediatek

git clone https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git -b lineage-22.2 device/mediatek/sepolicy_vndr

git clone https://github.com/AbuRider/vendor_extra.git -b master vendor/lineage-priv/keys

# Export
export BUILD_USERNAME=yusup
export BUILD_HOSTNAME=crave
export TZ=Asia/Jakarta
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=true

# initiate build setup
. build/envsetup.sh
lunch lineage_earth-bp1a-userdebug
mka derp -j$(nproc --all)
