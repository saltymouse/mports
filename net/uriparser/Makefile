# Created by: Ed Schouten <ed@FreeBSD.org>


PORTNAME=	uriparser
PORTVERSION=	0.8.4
CATEGORIES=	net
MASTER_SITES=	SF/${PORTNAME}/Sources/${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	URI parsing library

LICENSE=	bsd3
LICENSE_FILE=	${WRKSRC}/COPYING

GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--disable-doc --disable-test
INSTALL_TARGET=	install-strip
USES=		libtool pathfix tar:bzip2
USE_LDCONFIG=	yes

MAKE_JOBS_UNSAFE=yes

.include <bsd.port.mk>
