PORTNAME=	jansson
PORTVERSION=	2.13.1
CATEGORIES=	devel
MASTER_SITES=	http://www.digip.org/jansson/releases/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	C library for encoding, decoding, and manipulating JSON data

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		cpe pathfix pkgconfig gmake tar:bzip2 libtool
USE_LDCONFIG=	yes
GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
CPE_VENDOR=	jansson_project

.include <bsd.port.mk>
