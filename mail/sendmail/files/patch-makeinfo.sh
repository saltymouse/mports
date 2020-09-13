--- cf/sh/makeinfo.sh.orig	2014-03-05 00:59:45 UTC
+++ cf/sh/makeinfo.sh
@@ -52,7 +52,7 @@ then
 else
 	host=`uname -n`
 fi
-echo '#####' built by $user@$host on `date`
+echo '#####' built by $user@$host on `LC_TIME=C date`
 echo '#####' in `pwd` | sed 's/\/tmp_mnt//'
 echo '#####' using $1 as configuration include directory | sed 's/\/tmp_mnt//'
 echo "define(\`__HOST__', $host)dnl"
