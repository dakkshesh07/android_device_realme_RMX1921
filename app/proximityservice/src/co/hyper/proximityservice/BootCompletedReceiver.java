/*
 * Copyright (c) 2020 Harshit Jain <god@hyper-labs.tech>
 *
 * SPDX-License-Identifier: Apache-2.0
 * 
 * Purpose: BootCompleteReciever bootstrap class, allows RealmeProximityService
 * class to hook in and start the required listeners.
 * 
 */

package co.hyper.proximityservice;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

public class BootCompletedReceiver extends BroadcastReceiver {
    private static final String TAG = "RealmeProximityHelper";
    private static final boolean DEBUG = false;

    @Override
    public void onReceive(final Context context, Intent intent) {
        if (DEBUG) Log.d(TAG, "Starting");
        context.startService(new Intent(context, RealmeProximityHelperService.class));
    }
}
