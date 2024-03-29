#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE=RMX1921
VENDOR=realme

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d ${MY_DIR} ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup)
            CLEAN_VENDOR=false
            ;;
        -k | --kang)
            KANG="--kang"
            ;;
        -s | --section)
            SECTION="${2}"
            shift
            CLEAN_VENDOR=false
            ;;
        *)
            SRC="${1}"
            ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

adreno_blob_fixup() {
    patchelf --replace-needed "vendor.qti.hardware.display.mapper@3.0.so" "vendor.qti.hardware.display.mappershim.so" "${1}"
    patchelf --replace-needed "vendor.qti.hardware.display.mapper@4.0.so" "vendor.qti.hardware.display.mappershim.so" "${1}"
    patchelf --replace-needed "android.hardware.graphics.mapper@3.0.so" "android.hardware.graphics.mappershim.so" "${1}"
    patchelf --replace-needed "android.hardware.graphics.mapper@4.0.so" "android.hardware.graphics.mappershim.so" "${1}"
}

function blob_fixup() {
    case "${1}" in
        vendor/bin/sensors.qti | vendor/lib64/sensors.ssc.so | vendor/lib64/libssc.so | vendor/lib64/libsensorcal.so | vendor/lib64/libsnsdiaglog.so | vendor/lib64/libsnsapi.so | vendor/lib/sensors.ssc.so | vendor/lib/libssc.so | vendor/lib/libsensorcal.so | vendor/lib/libsnsdiaglog.so | vendor/lib/libsnsapi.so | odm/lib64/mediadrm/libwvdrmengine.so | odm/lib64/libwvhidl.so )
            "${PATCHELF}" --replace-needed "libprotobuf-cpp-lite-3.9.1.so" "libprotobuf-cpp-full-3.9.1.so" "${2}"
            ;;
        product/etc/permissions/vendor.qti.hardware.data.connection-V1.0-java.xml | product/etc/permissions/vendor.qti.hardware.data.connection-V1.1-java.xml | product/etc/permissions/vendor.qti.hardware.data.connectionaidl-V1-java.xml)
            sed -i 's/xml version="2.0"/xml version="1.0"/g' "${2}"
            ;;
    esac
}

# Initialize the helper
setup_vendor "${DEVICE}" "${VENDOR}" "${ANDROID_ROOT}" false "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

"${MY_DIR}/setup-makefiles.sh"
