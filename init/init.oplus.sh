#! /vendor/bin/sh
#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

if grep -q simcardnum.doublesim=1 /proc/cmdline; then
    setprop vendor.radio.multisim.config dsds
fi

# Get device codename
OPLUS_PROJECT=$(getprop "ro.boot.prjname")

if [ "$OPLUS_PROJECT" = "19601" ] || [ "$OPLUS_PROJECT" = "19605" ]; then
    # CN variant of Realme X and IN variant has different project name
    setprop ro.vendor.prjname 19605
    setprop ro.vendor.fp_type optical
elif [ "$OPLUS_PROJECT" = "18621" ] || [ "$OPLUS_PROJECT" = "19691" ]; then
    # Set common property for Realme 3 Pro and Realme 5 pro
    setprop ro.vendor.prjname 19691
    setprop ro.vendor.fp_type physical
else
   # Set as optical fingerprint for FOD overlays for realme XT
   setprop ro.vendor.fp_type optical
fi
