# Created by: Stanislav Sedov <stas@FreeBSD.org>

PORTNAME=	lcms2
PORTVERSION=	2.12
CATEGORIES=	graphics
MASTER_SITES=	https://github.com/mm2/Little-CMS/releases/download/lcms${PORTVERSION}/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Accurate, fast, and small-footprint color management engine

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/COPYING

USES=		libtool localbase:ldflags pathfix

GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
TEST_TARGET=	check
USE_LDCONFIG=	yes

PLIST_SUB=	PORTVERSION=${PORTVERSION}

OPTIONS_DEFINE=	DOCS JPEGICC TIFFICC
OPTIONS_DEFAULT=JPEGICC TIFFICC
OPTIONS_SUB=	yes
JPEGICC_DESC=	Build color profile applier for JPEG
TIFFICC_DESC=	Build color profile applier for TIFF

JPEGICC_CONFIGURE_WITH=	jpeg
JPEGICC_USES=		jpeg
TIFFICC_CONFIGURE_WITH=	tiff
TIFFICC_LIB_DEPENDS=	libtiff.so:graphics/tiff

post-install:
	${INSTALL_MAN} ${WRKSRC}/utils/linkicc/linkicc.1 ${WRKSRC}/utils/psicc/psicc.1 ${WRKSRC}/utils/transicc/transicc.1 ${PREFIX}/man/man1/

post-install-DOCS-on:
	${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}/
	${INSTALL_DATA} ${WRKSRC}/doc/*.pdf ${FAKE_DESTDIR}${DOCSDIR}/

.include <bsd.port.mk>
