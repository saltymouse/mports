
#

PORTNAME=	m17n-lib
PORTVERSION=	1.6.4
CATEGORIES=	devel
MASTER_SITES=	http://www.m17n.org/m17n-lib-download/ \
		http://anthesphoria.net/FreeBSD/ports/distfiles/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Library for multilingual text handling

LICENSE=	lgpl2.1

BUILD_DEPENDS=	bison:devel/bison \
		m17n-db>=1.6.2:devel/m17n-db
LIB_DEPENDS=	libfontconfig.so:x11-fonts/fontconfig \
		libfreetype.so:print/freetype2 \
		libfribidi.so:converters/fribidi \
		libgd.so:graphics/gd \
		libotf.so:print/libotf
RUN_DEPENDS=	m17n-db>=1.6.2:devel/m17n-db

MAKE_JOBS_UNSAFE=	yes

USES=		libtool pkgconfig
USE_XORG=	ice sm x11 xaw xft xt
USE_GNOME=	libxml2
USE_AUTOTOOLS=	autoconf 
USE_LDCONFIG=	yes

OPTIONS=	ISPELL	"With Ispell support" off \
		THAI	"With libThai support" off

.include <bsd.port.pre.mk>

CONFIGURE_ARGS+=	--disable-nls

CONFIGURE_ARGS+=	--without-anthy

.if defined(WITH_ISPELL)
BUILD_DEPENDS+=	ispell:textproc/ispell
RUN_DEPENDS+=	ispell:textproc/ispell
.else
CONFIGURE_ENV+=	HAVE_ISPELL=no
.endif

.if defined(WITH_THAI)
LIB_DEPENDS+=	libthai.so:devel/libthai
.else
CONFIGURE_ARGS+=	--without-libthai
.endif

post-patch:
	@${FIND} ${WRKSRC} -name "Makefile.in" | ${XARGS} ${REINPLACE_CMD} -e \
		's|$${libdir}/pkgconfig|$${prefix}/libdata/pkgconfig|g ; \
		 s|-ldl||g'

.include <bsd.port.post.mk>
