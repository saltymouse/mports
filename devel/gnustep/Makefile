 

PORTNAME=	gnustep
PORTVERSION=	1.28.0
CATEGORIES=	devel lang gnustep
MASTER_SITES=	# empty
DISTFILES=	# empty
EXTRACT_ONLY=	# empty

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Objective-C libraries based on the OpenStep standard

LICENSE=	gpl3 lgpl3
LICENSE_COMB=	multi

NO_BUILD=	yes
#NO_INSTALL=	yes

USES=		gnustep
USE_GNUSTEP=	back gui base

do-install:
	${MKDIR} ${PREFIX}/share/gnustep
	${TOUCH} ${PREFIX}/share/gnustep/keep.me

.include <bsd.port.mk>
