PORTNAME=	libmikmod
PORTVERSION=	3.3.11.1
CATEGORIES=	audio
MASTER_SITES=	SF/mikmod/libmikmod/${PORTVERSION}/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	MikMod Sound Library

LICENSE=	lgpl2.1

USES=		cpe gmake libtool pathfix pkgconfig
CPE_VENDOR=	raphael_assenat
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--disable-esd
USE_LDCONFIG=	yes

INFO=		mikmod

post-install:
	@${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/${PORTNAME}.so.3.3.0

.include <bsd.port.mk>
