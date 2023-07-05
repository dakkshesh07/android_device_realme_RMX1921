#
# Copyright (C) 2021-2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common PixelOS stuff
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)
TARGET_SUPPORTS_QUICK_TAP := true

# Inherit from RMX1921 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

PRODUCT_NAME := aosp_RMX1921
PRODUCT_BRAND := realme
PRODUCT_MANUFACTURER := realme
PRODUCT_DEVICE := RMX1921
PRODUCT_MODEL := RMX1921

PRODUCT_SYSTEM_NAME := RMX1921
PRODUCT_SYSTEM_DEVICE := RMX1921
PRODUCT_SYSTEM_MODEL := RMX1921

PRODUCT_GMS_CLIENTID_BASE := android-oppo

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="RMX1921-user 11 RKQ1.201217.002 1651205774457 release-keys" \
    TARGET_DEVICE=RMX1921 \
    TARGET_PRODUCT=RMX1921

# Set BUILD_FINGERPRINT variable to be picked up by both system and vendor build.prop
BUILD_FINGERPRINT := realme/RMX1921/RMX1921:11/RKQ1.201217.002/1651205774457:user/release-keys
PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.fingerprint=$(BUILD_FINGERPRINT)
