# -*- mode: Makefile; tab-width: 4; -*-
# ex: ts=4
#
# $MidnightBSD$ 
# $FreeBSD: ports/Mk/bsd.database.mk,v 1.14 2006/07/05 02:18:08 linimon Exp $
#

.if defined(_POSTMKINCLUDED) && !defined(Bdb_Post_Include)

Bdb_Post_Include=		bdb.mk
Bdb_Include_MAINTAINER=	ports@MidnightBSD.org

##
# USE_BDB		- Add Berkeley DB library dependency.
#				  If no version is given (by the maintainer via the port or
#				  by the user via defined variable), try to find the
#				  currently installed version.  Fall back to default if
#				  necessary (db41+).
# INVALID_BDB_VER
#				- This variable can be defined when the port doesn't
#				  support one or more versions of Berkeley DB.
# WANT_BDB_VER	- Maintainer can set a version of Berkeley DB to always
#				  build this port with (overrides WITH_BDB_VER).
# WITH_BDB_VER	- User defined global variable to set Berkeley DB version
# <UNIQUENAME>_WITH_BDB_VER
#				- User defined port specific variable to set
#				  Berkeley DB version
# WITH_BDB_HIGHEST
#				- Use the highest installed version of Berkeley DB
# BDB_LIB_NAME	- This variable is automatically set to the name of the
#				  Berkeley DB library (default: db41)
# BDB_LIB_CXX_NAME
#				- This variable is automatically set to the name of the
#				  Berkeley DB c++ library (default: db41_cxx)
# BDB_INCLUDE_DIR
#				- This variable is automatically set to the location of
#				  the Berkeley DB include directory.
#				  (default: ${LOCALBASE}/include/db41)
# BDB_LIB_DIR	- This variable is automatically set to the location of
#				  the Berkeley DB library directory.
# BDB_VER		- Detected Berkeley DB version.


.include "${PORTSDIR}/Mk/components/default-versions.mk"

_USE_BDB_save:=${USE_BDB}
_WITH_BDB_VER_save:=${WITH_BDB_VER}

_DB_PORTS=	48 5 6
_DB_DEFAULTS=	48 5    # does not include 6 due to different licensing
#       but user can re-add it through WITH_BDB6_PERMITTED
. if defined(WITH_BDB6_PERMITTED)
_DB_DEFAULTS+=	6
. endif

# Dependency lines for different db versions
db48_DEPENDS=	libdb-4.8.so:${PORTSDIR}/databases/db48
db5_DEPENDS=	libdb-5.3.so:${PORTSDIR}/databases/db5
db6_DEPENDS=	libdb-6.1.so:${PORTSDIR}/databases/db6
# Detect db versions by finding some files
db48_FIND=	${LOCALBASE}/include/db48/db.h
db5_FIND=	${LOCALBASE}/include/db5/db.h
db6_FIND=	${LOCALBASE}/include/db6/db.h

# Override the global WITH_BDB_VER with the
# port specific <UNIQUENAME>_WITH_BDB_VER
.if defined(${UNIQUENAME:tu:S,-,_,}_WITH_BDB_VER)
WITH_BDB_VER=	${${UNIQUENAME:tu:S,-,_,}_WITH_BDB_VER}
.endif

# Override USE_BDB with global WITH_BDB_VER
.if defined(WITH_BDB_VER)
. if ${WITH_BDB_VER} != 1
USE_BDB=	${WITH_BDB_VER}
. endif
.endif

# Override USE_BDB with maintainer's WANT_BDB_VER
.if defined(WANT_BDB_VER)
USE_BDB=	${WANT_BDB_VER}
.endif

# Compatiblity hack:
# upgrade older plussed versions to 48+
_BDB_OLDPLUSVERS=4+ 40+ 41+ 42+ 43+ 44+ 45+ 46+ 47+
.for i in ${USE_BDB}
. if ${_BDB_OLDPLUSVERS:M${i}}
USE_BDB:=	48+
. endif
.endfor

.if ${USE_BDB} == yes
USE_BDB:=	48+
.endif

# 1. detect installed versions
_INST_BDB_VER=
.for bdb in ${_DB_PORTS}
. if exists(${db${bdb}_FIND})
_INST_BDB_VER+=${bdb}
. endif
.endfor

# 2. parse supported versions:
# 2a. build list from USE_BDB
_SUPP_BDB_VER=
_USE_BDB:=${USE_BDB:C,\+$,,:C/(.)(.)$/\1.\2/}
.if !empty(USE_BDB:M*+)
. for bdb in ${_DB_PORTS:C/(.)(.)$/\1.\2/}
.  if ${_USE_BDB} <= ${bdb}
_SUPP_BDB_VER+=${bdb:C/\.//}
.  endif
. endfor
.else
_SUPP_BDB_VER=${USE_BDB}
.endif
# 2b. expand INVALID_BDB_VER if given with "+":
.if !empty(INVALID_BDB_VER:M*+)
_INV_BDB:=${INVALID_BDB_VER:C,\+$,,:C/(.)(.)$/\1.\2/}
_INV_BDB_VER:=
. for bdb in ${_DB_PORTS:C/(.)(.)$/\1.\2/}
.  if ${_INV_BDB} <= ${bdb}
_INV_BDB_VER+=${bdb:C/\.//}
.  endif
. endfor
.else
_INV_BDB_VER:=${INVALID_BDB_VER}
.endif
# 2c. strip versions from INVALID_BDB_VER out of _SUPP_BDB_VER
.for unsupp in ${_INV_BDB_VER}
_SUPP_BDB_VER:=${_SUPP_BDB_VER:N${unsupp}}
.endfor

# 3a. calculate intersection in _INST_BDB_VER to see if there
# is a usable installed version
.for i in ${_INST_BDB_VER}
. if empty(_SUPP_BDB_VER:M${i})
_INST_BDB_VER:= ${_INST_BDB_VER:N${i}}
. endif
.endfor
_ELIGIBLE_BDB_VER:=${_INST_BDB_VER}

# 3b. if there is no usable version installed, check defaults
.if empty(_INST_BDB_VER)
_DFLT_BDB_VER:=${_DB_DEFAULTS}
# make sure we use a reasonable version for package builds
_WITH_BDB_HIGHEST=yes
. for i in ${_DFLT_BDB_VER}
.  if empty(_SUPP_BDB_VER:M${i})
_DFLT_BDB_VER:= ${_DFLT_BDB_VER:N${i}}
.  endif
. endfor
_ELIGIBLE_BDB_VER:=${_DFLT_BDB_VER}
.endif

# 4. elect a version
_BDB_VER=
.for i in ${_ELIGIBLE_BDB_VER}
. if !empty(WITH_BDB_HIGHEST) || !empty(_WITH_BDB_HIGHEST) || empty(${_BDB_VER})
_BDB_VER:=${i}
. endif
.endfor

# 5. catch errors or set variables
.if empty(_BDB_VER)
IGNORE=		cannot install: no eligible BerkeleyDB version. Requested: ${USE_BDB}, incompatible: ${_INV_BDB_VER}. Try: make debug-bdb
.else
. if defined(BDB_BUILD_DEPENDS)
BUILD_DEPENDS+=	${db${_BDB_VER}_FIND}:${db${_BDB_VER}_DEPENDS:C/^libdb.*://}
. else
LIB_DEPENDS+=	${db${_BDB_VER}_DEPENDS}
. endif
. if ${_BDB_VER} == 48
BDB_LIB_NAME=		db-4.8
BDB_LIB_CXX_NAME=	db_cxx-4.8
BDB_LIB_DIR=		${LOCALBASE}/lib/db48
. elif ${_BDB_VER} == 5
BDB_LIB_NAME=		db-5.3
BDB_LIB_CXX_NAME=	db_cxx-5.3
BDB_LIB_DIR=		${LOCALBASE}/lib/db5
. elif ${_BDB_VER} == 6
BDB_LIB_NAME=		db-6.1
BDB_LIB_CXX_NAME=	db_cxx-6.1
BDB_LIB_DIR=		${LOCALBASE}/lib/db6
. endif
BDB_LIB_NAME?=		db${_BDB_VER}
BDB_LIB_CXX_NAME?=	db${_BDB_VER}_cxx
BDB_INCLUDE_DIR?=	${LOCALBASE}/include/db${_BDB_VER}
BDB_LIB_DIR?=		${LOCALBASE}/lib
.endif
BDB_VER=		${_BDB_VER}

debug-bdb:
	@${ECHO_CMD} "--INPUTS----------------------------------------------------"
	@${ECHO_CMD} "${UNIQUENAME:tu:S,-,_,}_WITH_BDB_VER: ${${UNIQUENAME:tu:S,-,_,}_WITH_BDB_VER}"
	@${ECHO_CMD} "WITH_BDB_VER: ${_WITH_BDB_VER_save}"
	@${ECHO_CMD} "WANT_BDB_VER: ${WANT_BDB_VER}"
	@${ECHO_CMD} "BDB_BUILD_DEPENDS: ${BDB_BUILD_DEPENDS}"
	@${ECHO_CMD} "USE_BDB (original): ${_USE_BDB_save}"
	@${ECHO_CMD} "WITH_BDB_HIGHEST (original): ${WITH_BDB_HIGHEST}"
	@${ECHO_CMD} "--PROCESSING------------------------------------------------"
	@${ECHO_CMD} "supported versions: ${_SUPP_BDB_VER}"
	@${ECHO_CMD} "invalid versions: ${_INV_BDB_VER}"
	@${ECHO_CMD} "installed versions: ${_INST_BDB_VER}"
	@${ECHO_CMD} "eligible versions: ${_ELIGIBLE_BDB_VER}"
	@${ECHO_CMD} "USE_BDB (effective): ${USE_BDB}"
	@${ECHO_CMD} "WITH_BDB_HIGHEST (override): ${_WITH_BDB_HIGHEST}"
	@${ECHO_CMD} "--OUTPUTS---------------------------------------------------"
	@${ECHO_CMD} "IGNORE=${IGNORE}"
	@${ECHO_CMD} "BDB_VER=${BDB_VER}"
	@${ECHO_CMD} "BDB_INCLUDE_DIR=${BDB_INCLUDE_DIR}"
	@${ECHO_CMD} "BDB_LIB_NAME=${BDB_LIB_NAME}"
	@${ECHO_CMD} "BDB_LIB_CXX_NAME=${BDB_LIB_CXX_NAME}"
	@${ECHO_CMD} "BDB_LIB_DIR=${BDB_LIB_DIR}"
	@${ECHO_CMD} "BUILD_DEPENDS=${BUILD_DEPENDS:M*/databases/db*}"
	@${ECHO_CMD} "LIB_DEPENDS=${LIB_DEPENDS:M*/databases/db*}"
	@${ECHO_CMD} "------------------------------------------------------------"

# Obsolete variables - ports can define these to want users about
# variables that may be in /etc/make.conf but that are no longer
# effective:
.if defined(OBSOLETE_BDB_VAR)
. for var in ${OBSOLETE_BDB_VAR}
.  if defined(${var})
BAD_VAR+=	${var},
.  endif
. endfor
. if defined(BAD_VAR)
_IGNORE_MSG=	Obsolete variable(s) ${BAD_VAR} use WITH_BDB_VER or ${UNIQUENAME:tu:S,-,_,}_WITH_BDB_VER to select Berkeley DB version
.  if defined(IGNORE)
IGNORE+= ${_IGNORE_MSG}
.  else
IGNORE=	${_IGNORE_MSG}
.  endif
. endif
.endif

.endif #defined(_POSTMKINCLUDED) && !defined(Bdb_Post_Include)
