/*
 * Copyright (C) 2021 LineageOS Project
 *
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <string.h>
#include <unistd.h>

#include <cstdlib>
#include <fstream>
#include <vector>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <android-base/properties.h>
#include <sys/_system_properties.h>
#include <sys/sysinfo.h>

#include "property_service.h"
#include "vendor_init.h"

using android::base::GetProperty;
using std::string;

std::vector<string> ro_props_default_source_order = {
    "", "bootimage.", "odm.", "product.", "system.", "system_ext.", "vendor."};

#define GB(b) (b * 1024ull * 1024 * 1024)

void property_override(char const prop[], char const value[], bool add = true) {
  prop_info *pi;

  pi = (prop_info *)__system_property_find(prop);

  if (pi)
    __system_property_update(pi, value, strlen(value));
  else if (add)
    __system_property_add(prop, strlen(prop), value, strlen(value));
}

void load_dalvikvm_properties() {
  struct sysinfo sys;
  sysinfo(&sys);
  if (sys.totalram > GB(5)) {
    // phone-xhdpi-6144-dalvik-heap.mk
    property_override("dalvik.vm.heapstartsize", "16m");
    property_override("dalvik.vm.heapgrowthlimit", "256m");
    property_override("dalvik.vm.heapsize", "512m");
    property_override("dalvik.vm.heaptargetutilization", "0.5");
    property_override("dalvik.vm.heapminfree", "8m");
    property_override("dalvik.vm.heapmaxfree", "32m");
    property_override("ro.config.low_ram", "false");
  } else {
    // from - phone-xhdpi-4096-dalvik-heap.mk
    property_override("dalvik.vm.heapstartsize", "8m");
    property_override("dalvik.vm.heapgrowthlimit", "192m");
    property_override("dalvik.vm.heapsize", "512m");
    property_override("dalvik.vm.heaptargetutilization", "0.6");
    property_override("dalvik.vm.heapminfree", "8m");
    property_override("dalvik.vm.heapmaxfree", "16m");
    property_override("ro.config.low_ram", "true");
  }
}

void nfc_sku_support() {
  std::ifstream nfcSupportFile("/sys/module/pn553/parameters/sku_support_nfc");
  std::string nfcSupportSku;

  std::getline(nfcSupportFile, nfcSupportSku);
  if (nfcSupportSku == "1") {
    property_override("ro.boot.product.hardware.sku", "nfc");
  }
}

void vendor_load_properties() {
  //
  nfc_sku_support();
  // dalvikvm props
  load_dalvikvm_properties();
  // SafetyNet workaround
  property_override("ro.boot.verifiedbootstate", "green");
}
