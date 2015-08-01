--- cmake/build_configurations/compiler_options.cmake.orig	2014-12-05 10:49:17.394216277 +0000
+++ cmake/build_configurations/compiler_options.cmake	2014-12-05 10:50:58.144209859 +0000
@@ -25,7 +25,7 @@
 
   # Default GCC flags
   IF(CMAKE_COMPILER_IS_GNUCC)
-    SET(COMMON_C_FLAGS               "-g -fabi-version=2 -fno-omit-frame-pointer -fno-strict-aliasing")
+    SET(COMMON_C_FLAGS               "-g -fno-omit-frame-pointer -fno-strict-aliasing")
     # Disable inline optimizations for valgrind testing to avoid false positives
     IF(WITH_VALGRIND)
       SET(COMMON_C_FLAGS             "-fno-inline ${COMMON_C_FLAGS}")
@@ -34,7 +34,7 @@
     SET(CMAKE_C_FLAGS_RELWITHDEBINFO "-O3 ${COMMON_C_FLAGS}")
   ENDIF()
   IF(CMAKE_COMPILER_IS_GNUCXX)
-    SET(COMMON_CXX_FLAGS               "-g -fabi-version=2 -fno-omit-frame-pointer -fno-strict-aliasing")
+    SET(COMMON_CXX_FLAGS               "-g -fno-omit-frame-pointer -fno-strict-aliasing")
     # Disable inline optimizations for valgrind testing to avoid false positives
     IF(WITH_VALGRIND)
       SET(COMMON_CXX_FLAGS             "-fno-inline ${COMMON_CXX_FLAGS}")
