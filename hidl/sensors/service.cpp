/*
 * Copyright (C) 2019 The Android Open Source Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <android/hardware/sensors/2.0/ISensors.h>
#include <hidl/HidlTransportSupport.h>
#include <log/log.h>
#include <utils/StrongPointer.h>
#include "HalProxy.h"

using android::hardware::configureRpcThreadpool;
using android::hardware::joinRpcThreadpool;
using android::hardware::sensors::V2_0::ISensors;
using android::hardware::sensors::V2_1::implementation::HalProxyV2_0;

int main(int /* argc */, char** /* argv */) {
    configureRpcThreadpool(1, true);

    android::sp<ISensors> halProxy = new HalProxyV2_0();
    if (halProxy->registerAsService() != ::android::OK) {
        ALOGE("Failed to register Sensors HAL instance");
        return -1;
    }

    joinRpcThreadpool();
    return 1;  // joinRpcThreadpool shouldn't exit
}
