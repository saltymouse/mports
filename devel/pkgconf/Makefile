PORTNAME=	pkgconf
PORTVERSION=	1.7.4
PORTEPOCH=	1
CATEGORIES=	devel
MASTER_SITES=	https://distfiles.dereferenced.org/pkgconf/ \
		http://files.etoilebsd.net/pkgconf/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Utility to help to configure compiler and linker flags

LICENSE=	iscl

# circular dependency
#TEST_DEPENDS=	kyua:devel/kyua

USES=		tar:xz libtool pathfix
GNU_CONFIGURE=	yes
INSTALL_TARGET=	install-strip
USE_LDCONFIG=	yes
#TEST_TARGET=	check
NO_TEST=	yes
CONFIGURE_ARGS=	--with-pkg-config-dir=${PREFIX}/libdata/pkgconfig:${PREFIX}/lib/pkgconfig:/usr/libdata/pkgconfig \
		--with-system-libdir=/usr/lib \
		--with-system-includedir=/usr/include
MAKE_ARGS=	MANDIR="${MAN1PREFIX}/man/man1"

OPTIONS_DEFINE=	DOCS

post-install:
	${LN} -sf pkgconf ${STAGEDIR}${PREFIX}/bin/pkg-config

.include <bsd.port.mk>
