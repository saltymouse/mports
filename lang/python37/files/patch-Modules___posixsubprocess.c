# Add closefrom(2) support
# https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=242274
# https://bugs.python.org/issue38061
# TODO: Upstream

--- Modules/_posixsubprocess.c.orig	2019-10-14 22:32:36 UTC
+++ Modules/_posixsubprocess.c
@@ -236,8 +236,15 @@ _close_fds_by_brute_force(long start_fd, PyObject *py_
         start_fd = keep_fd + 1;
     }
     if (start_fd <= end_fd) {
-        for (fd_num = start_fd; fd_num < end_fd; ++fd_num) {
-            close(fd_num);
+#if defined(__FreeBSD__) || defined(__MidnightBSD__)
+        if (end_fd >= sysconf(_SC_OPEN_MAX)) {
+            closefrom(start_fd);
+        } else
+#endif
+        {
+            for (fd_num = start_fd; fd_num < end_fd; ++fd_num) {
+                close(fd_num);
+            }
         }
     }
 }
