# Created by: ijliao

PORTNAME=	fribidi
PORTVERSION=	1.0.10
CATEGORIES=	converters
MASTER_SITES=	https://github.com/fribidi/fribidi/releases/download/v${PORTVERSION}/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Free Implementation of the Unicode Bidirectional Algorithm

LICENSE=	lgpl2.1
LICENSE_FILE=	${WRKSRC}/COPYING

USES=		meson tar:xz
USE_LDCONFIG=	yes
MESON_ARGS=	-Dtests=false

post-patch:
	@${SED} -e 's|%%LOCALBASE%%|${LOCALBASE}|g' < \
		${FILESDIR}/fribidi-config > ${WRKDIR}/fribidi-config

post-install:
	${INSTALL_SCRIPT} ${WRKDIR}/fribidi-config ${STAGEDIR}${PREFIX}/bin

.include <bsd.port.mk>
