#!/system/bin/sh
#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Get device codename
OPLUS_PROJECT=$(getprop "ro.boot.prjname")

# Let only hardware specific fingerprint firmware survive
if [ "$OPLUS_PROJECT" = "18621" ] || [ "$OPLUS_PROJECT" = "18691" ]; then
   rm -r /odm/vendor/firmware/*goodix*
else
   rm -r /odm/vendor/firmware/*a_fp*
fi

# Dalvik heap
if grep MemTotal /proc/meminfo | awk '{print $2 / 1024}' < 4000; then
   # Dalvik heap configs for 4GB variants
   sed -i 's/heapstartsize=16m/heapstartsize=8m/g' /vendor/build.prop
   sed -i 's/heapgrowthlimit=256m/heapgrowthlimit=192m/g' /vendor/build.prop
   sed -i 's/heaptargetutilization=0.5/heaptargetutilization=0.6/g' /vendor/build.prop
   sed -i 's/heapmaxfree=32m/heapmaxfree=16m/g' /vendor/build.prop
fi

# Camera blob fixing for each project version
mkdir /tmp/vendor
cp -rfL /vendor/$OPLUS_PROJECT/* /tmp/vendor
rm -rf /vendor/1*
cp -rf /tmp/vendor/* /vendor/

# Audio and Sensor blobs
mkdir /tmp/odm
cp -rfL /odm/$OPLUS_PROJECT/* /tmp/odm
rm -rf /odm/1*
cp -rf /tmp/odm/* /odm/
