#!/bin/bash

rom_fp="$(date +%y%m%d)"
mkdir -p release/$rom_fp/
set -e

if [ "$#" -ne 4 ];then
	echo "Usage: $0 <android-8.1> <carbon|lineage> <patch to release patches.zip>"
	exit 0
fi
localManifestBranch=$1
rom=$2
patches=$3

if [ "$rom" == "carbon" ];then
	repo init -u https://github.com/CarbonROM/android -b cr-6.1
elif [ "$rom" == "lineage" ];tehn
	repo init -u https://github.com/LineageOS/android.git -b lineage-15.1
fi

if [ -d .repo/local_manifests ] ;then
	( cd .repo/local_manifests; git fetch; git reset --hard; git checkout origin/$localManifestBranch)
else
	git clone https://github.com/phhusson/treble_manifest .repo/local_manifests -b $localManifestBranch
fi
#We don't want to replace from AOSP since we'll be applying patches by hand
rm -f .repo/local_manifests/replace.xml

repo sync -j 4 --force-sync
(cd device/phh/treble; git clean -fdx; bash generate.sh $rom)

bash "$(dirname "$0")/apply-patches.sh" $patches

. build/envsetup.sh

buildVariant() {
	lunch $1
	make BUILD_NUMBER=$rom_fp installclean
	make BUILD_NUMBER=$rom_fp -j8 systemimage
	make BUILD_NUMBER=$rom_fp vndk-test-sepolicy
	cp $OUT/system.img release/$rom_fp/system-${2}.img
}

repo manifest -r > release/$rom_fp/manifest.xml
buildVariant treble_arm64_avN-userdebug arm64-aonly
buildVariant treble_arm64_bvN-userdebug arm64-ab
buildVariant treble_arm_avN-userdebug arm-aonly