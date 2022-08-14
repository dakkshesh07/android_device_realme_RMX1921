#! /vendor/bin/sh
#
# Copyright (C) 2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

if grep -q G_OPTICAL /proc/fp_id; then
    setprop vendor.fingerprint.sensor_type optical
else
    setprop vendor.fingerprint.sensor_type physical
fi
