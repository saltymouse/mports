--- cmake/ssl.cmake.orig	2019-12-06 10:41:47 UTC
+++ cmake/ssl.cmake
@@ -193,7 +193,8 @@ MACRO (MYSQL_CHECK_SSL)
       )
     SET(OPENSSL_VERSION ${OPENSSL_VERSION} CACHE INTERNAL "")
 
-    IF("${OPENSSL_VERSION}" VERSION_GREATER "1.1.0")
+    CHECK_SYMBOL_EXISTS(TLS1_3_VERSION "openssl/tls1.h" HAVE_TLS1_3_VERSION)
+    IF(HAVE_TLS1_3_VERSION)
        ADD_DEFINITIONS(-DHAVE_TLSv13)
        SET(HAVE_TLSv13 1)
        IF(SOLARIS)
@@ -203,7 +204,13 @@ MACRO (MYSQL_CHECK_SSL)
     IF(OPENSSL_INCLUDE_DIR AND
        OPENSSL_LIBRARY   AND
        CRYPTO_LIBRARY      AND
-       OPENSSL_MAJOR_VERSION STREQUAL "1"
+       OPENSSL_MAJOR_VERSION VERSION_GREATER_EQUAL "1"
+      )
+      SET(OPENSSL_FOUND TRUE)
+    ELSEIF(OPENSSL_INCLUDE_DIR AND
+       OPENSSL_LIBRARY   AND
+       CRYPTO_LIBRARY      AND
+       OPENSSL_MAJOR_VERSION STREQUAL "2"
       )
       SET(OPENSSL_FOUND TRUE)
     ELSE()
