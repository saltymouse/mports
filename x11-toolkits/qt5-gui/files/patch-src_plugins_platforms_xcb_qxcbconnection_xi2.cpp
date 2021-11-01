--- src/plugins/platforms/xcb/qxcbconnection_xi2.cpp.orig	2019-08-05 16:22:20.511830000 -0500
+++ src/plugins/platforms/xcb/qxcbconnection_xi2.cpp	2019-08-05 16:25:40.211970000 -0500
@@ -43,6 +43,7 @@
 #include "qxcbwindow.h"
 #include "qtouchdevice.h"
 #include "QtCore/qmetaobject.h"
+#include "QtCore/qendian.h"
 #include <qpa/qwindowsysteminterface_p.h>
 #include <QDebug>
 #include <cmath>
@@ -66,6 +67,7 @@
     xiEventMask.mask = XCB_INPUT_XI_EVENT_MASK_HIERARCHY;
     xiEventMask.mask |= XCB_INPUT_XI_EVENT_MASK_DEVICE_CHANGED;
     xiEventMask.mask |= XCB_INPUT_XI_EVENT_MASK_PROPERTY;
+    xiEventMask.mask = qToLittleEndian(xiEventMask.mask);
     xcb_input_xi_select_events(xcb_connection(), rootWindow(), 1, &xiEventMask.header);
 }
 
@@ -90,7 +92,7 @@
     qt_xcb_input_event_mask_t mask;
     mask.header.deviceid = XCB_INPUT_DEVICE_ALL_MASTER;
     mask.header.mask_len = 1;
-    mask.mask = bitMask;
+    mask.mask = qToLittleEndian(bitMask);
     xcb_void_cookie_t cookie =
             xcb_input_xi_select_events_checked(xcb_connection(), window, 1, &mask.header);
     xcb_generic_error_t *error = xcb_request_check(xcb_connection(), cookie);
@@ -359,7 +361,7 @@
         qt_xcb_input_event_mask_t xiMask;
         xiMask.header.deviceid = XCB_INPUT_DEVICE_ALL_MASTER;
         xiMask.header.mask_len = 1;
-        xiMask.mask = mask;
+        xiMask.mask = qToLittleEndian(mask);
 
         xcb_void_cookie_t cookie =
                 xcb_input_xi_select_events_checked(xcb_connection(), window, 1, &xiMask.header);
@@ -386,7 +388,7 @@
             tabletDevices.insert(deviceId);
             xiEventMask[i].header.deviceid = deviceId;
             xiEventMask[i].header.mask_len = 1;
-            xiEventMask[i].mask = mask;
+            xiEventMask[i].mask = qToLittleEndian(mask);
         }
         xcb_input_xi_select_events(xcb_connection(), window, nrTablets, &(xiEventMask.data()->header));
     }
@@ -402,7 +404,7 @@
 #endif
             xiEventMask[i].header.deviceid = scrollingDevice.deviceId;
             xiEventMask[i].header.mask_len = 1;
-            xiEventMask[i].mask = mask;
+            xiEventMask[i].mask = qToLittleEndian(mask);
             i++;
         }
         xcb_input_xi_select_events(xcb_connection(), window, i, &(xiEventMask.data()->header));
