/*
 * Copyright (C) 2021 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#ifndef ANDROID_HARDWARE_BIOMETRICS_FINGERPRINT_V2_3_BIOMETRICSFINGERPRINT_H
#define ANDROID_HARDWARE_BIOMETRICS_FINGERPRINT_V2_3_BIOMETRICSFINGERPRINT_H

#include <android/hardware/biometrics/fingerprint/2.1/types.h>
#include <android/hardware/biometrics/fingerprint/2.3/IBiometricsFingerprint.h>
#include <android/log.h>
#include <hardware/fingerprint.h>
#include <hardware/hardware.h>
#include <hidl/MQDescriptor.h>
#include <hidl/Status.h>
#include <log/log.h>
#include <vendor/oppo/hardware/biometrics/fingerprint/2.1/IBiometricsFingerprint.h>

namespace android {
namespace hardware {
namespace biometrics {
namespace fingerprint {
namespace V2_3 {
namespace implementation {

using ::android::OK;
using ::android::sp;
using ::android::status_t;
using ::android::hardware::hidl_string;
using ::android::hardware::hidl_vec;
using ::android::hardware::Return;
using ::android::hardware::Void;
using ::android::hardware::biometrics::fingerprint::V2_1::
    IBiometricsFingerprintClientCallback;
using ::android::hardware::biometrics::fingerprint::V2_1::RequestStatus;
using ::android::hardware::biometrics::fingerprint::V2_3::
    IBiometricsFingerprint;

struct BiometricsFingerprint : public IBiometricsFingerprint {
public:
  BiometricsFingerprint();

  // Methods from
  // ::android::hardware::biometrics::fingerprint::V2_3::IBiometricsFingerprint
  // follow.
  Return<uint64_t> setNotify(
      const sp<IBiometricsFingerprintClientCallback> &clientCallback) override;
  Return<uint64_t> preEnroll() override;
  Return<RequestStatus> enroll(const hidl_array<uint8_t, 69> &hat, uint32_t gid,
                               uint32_t timeoutSec) override;
  Return<RequestStatus> postEnroll() override;
  Return<uint64_t> getAuthenticatorId() override;
  Return<RequestStatus> cancel() override;
  Return<RequestStatus> enumerate() override;
  Return<RequestStatus> remove(uint32_t gid, uint32_t fid) override;
  Return<RequestStatus> setActiveGroup(uint32_t gid,
                                       const hidl_string &storePath) override;
  Return<RequestStatus> authenticate(uint64_t operationId,
                                     uint32_t gid) override;
  Return<bool> isUdfps(uint32_t sensorID) override;
  Return<void> onFingerDown(uint32_t x, uint32_t y, float minor,
                            float major) override;
  Return<void> onFingerUp() override;

private:
  sp<vendor::oppo::hardware::biometrics::fingerprint::V2_1::
         IBiometricsFingerprint>
      mOppoBiometricsFingerprint;
  sp<vendor::oppo::hardware::biometrics::fingerprint::V2_1::
         IBiometricsFingerprintClientCallback>
      mOppoClientCallback;
  static Return<RequestStatus> OppoToAOSPRequestStatus(
      vendor::oppo::hardware::biometrics::fingerprint::V2_1::RequestStatus req);
};

} // namespace implementation
} // namespace V2_3
} // namespace fingerprint
} // namespace biometrics
} // namespace hardware
} // namespace android

#endif // ANDROID_HARDWARE_BIOMETRICS_FINGERPRINT_V2_3_BIOMETRICSFINGERPRINT_H
