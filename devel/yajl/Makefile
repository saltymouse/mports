PORTNAME=	yajl
PORTVERSION=	2.1.0
PORTREVISION=	3
CATEGORIES=	devel

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Portable JSON parsing and serialization library in ANSI C

LICENSE=	iscl

USE_GITHUB=	yes
GH_ACCOUNT=	lloyd

WRKSRC=		${WRKDIR}/yajl-2.1.0

CFLAGS+=	-g -O0

USE_LDCONFIG=	yes
USES=		cmake

PLIST_SUB=	VERSION=${PORTVERSION}

post-patch:
	@${REINPLACE_CMD} -e "s,share/pkgconfig,libdata/pkgconfig,g" \
		${WRKSRC}/src/CMakeLists.txt
	@${REINPLACE_CMD} -e 's|include/yajl|include|' \
		${WRKSRC}/src/yajl.pc.cmake

.include <bsd.port.mk>
