
#
# Sets a library dependency on gettext-runtime and a build dependency
# on gettext-tools.  Same as "USES=gettext-runtime gettext-tools".
#
# Feature:	gettext
# Usage:	USES=gettext

.if !defined(_INCLUDE_USES_GETTEXT_MK)
_INCLUDE_USES_GETTEXT_MK=	yes

.if !empty(gettext_ARGS)
IGNORE=		USES=gettext does not take arguments
.endif

.include "${MPORTEXTENSIONS}/gettext-runtime.mk"
.include "${MPORTEXTENSIONS}/gettext-tools.mk"

.endif
