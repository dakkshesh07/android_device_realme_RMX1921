/*
 * Copyright (c) 2020 Harshit Jain <god@hyper-labs.tech>
 *
 * SPDX-License-Identifier: Apache-2.0
 *
 * Purpose: This file registers display state listener and makes sure proximity
 * sensor is only triggered on display.STATE_OFF and when fd_enable = 1 which
 * signifies that the system has held a proximity wakelock indicating
 * touchpanel proximity has suspended and no events are recieved from it thus
 * its now time to trigger the infrared proximity and take events from it.
 * 
 */

 package co.hyper.proximityservice;

import android.content.Context;
import android.hardware.display.DisplayManager;
import android.hardware.display.DisplayManager.DisplayListener;
import android.view.Display;
import android.util.Log;

public class DisplayStateHelper implements DisplayListener {
     private static final String TAG = "DisplayStateListener";
     private static final boolean DEBUG = false;
     private Context mcontext;
     private InfraredSensor mFakeProximity;

     public DisplayStateHelper(Context context){
        if (DEBUG) Log.d(TAG, "Initialising display state listner constructor");
         mcontext = context;
         mFakeProximity = new InfraredSensor(context);
     }

     @Override
     public void onDisplayAdded(int displayId) {
        /* Empty */
     }
   
     @Override
     public void onDisplayRemoved(int displayId) {
        /* Empty "*/
     }
     
     @Override
     public void onDisplayChanged(int displayId) {
       if (displayId == Display.DEFAULT_DISPLAY && isDefaultDisplayOff(mcontext)) {
           // register proximity
           if (DEBUG) Log.d(TAG, "Display OFF, Attempting to register proximity sensor");
           mFakeProximity.enable();
       } else {
           // unregister proximity
           if (DEBUG) Log.d(TAG, "Display ON, Attempting to unregister porximity sensor");
           mFakeProximity.disable();
       }
    }

    void enable() {
        /* Enable the lister */
        if (DEBUG) Log.d(TAG, "Registering display state listner");
        mcontext.getSystemService(DisplayManager.class).registerDisplayListener(this, null);
        mFakeProximity.disable();
    }

    void disable() {
        /* kill the listener */
        if (DEBUG) Log.d(TAG, "Killing display state listener");
        mcontext.getSystemService(DisplayManager.class).unregisterDisplayListener(this);
        mFakeProximity.disable();
    }

    private static boolean isDefaultDisplayOff(Context context) {
        Display display = context.getSystemService(DisplayManager.class).getDisplay(Display.DEFAULT_DISPLAY);
        return display.getState() == Display.STATE_OFF;
      }
}
