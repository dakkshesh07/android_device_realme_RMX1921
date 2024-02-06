#
# Copyright (C) 2021-2022 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
TARGET_SUPPORTS_OMX_SERVICE := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common PixelOS stuff
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)
TARGET_SUPPORTS_QUICK_TAP := true
TARGET_SUPPORTS_NEXT_GEN_ASSISTANT := true

# Inherit from RMX1921 device
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# Viper
$(call inherit-product, packages/apps/ViPER4AndroidFX/config.mk)

# Device identifier.
PRODUCT_NAME := aosp_RMX1921
PRODUCT_DEVICE := RMX1921
PRODUCT_MODEL := RMX1921

PRODUCT_BRAND := realme
PRODUCT_MANUFACTURER := realme

PRODUCT_SYSTEM_MODEL := RMX1921
PRODUCT_SYSTEM_NAME := RMX1921
PRODUCT_SYSTEM_DEVICE := RMX1921

PRODUCT_GMS_CLIENTID_BASE := android-oppo

# Build info
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="RMX1921-user 11 RKQ1.201217.002 1651205774457 release-keys" \
    TARGET_DEVICE=$(PRODUCT_SYSTEM_DEVICE) \
    TARGET_PRODUCT=$(PRODUCT_SYSTEM_NAME)

BUILD_FINGERPRINT := realme/RMX1921/RMX1921:11/RKQ1.201217.002/1651205774457:user/release-keys
