PORTNAME=	libX11
PORTVERSION=	1.6.12
PORTEPOCH=	1
CATEGORIES=	x11

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	X11 library

LICENSE=	mit

USES=		cpe perl5 xorg xorg-cat:lib
USE_XORG=	xau xdmcp xtrans xorgproto xcb
USE_PERL5=	build
CPE_VENDOR=	x

CONFIGURE_ARGS+=	--datadir=${PREFIX}/lib \
			--without-xmlto \
			--disable-specs
CONFIGURE_ENV+=	ac_cv_path_PS2PDF=""
INSTALL_TARGET=	install-strip

post-patch:
	@${REINPLACE_CMD} 's/test.*-traditional.*;/true;/' \
		${WRKSRC}/configure
	@${REINPLACE_CMD} '/^install-data-am:/,/^$$/ \
		s/install-specDATA//' ${WRKSRC}/nls/Makefile.in

.include <bsd.port.mk>
