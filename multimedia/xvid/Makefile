

PORTNAME=	xvid
PORTVERSION=	1.3.2
PORTREVISION=	1
PORTEPOCH=	1
CATEGORIES=	multimedia
MASTER_SITES=	http://downloads.xvid.org/downloads/
DISTNAME=	${PORTNAME}core-${PORTVERSION}

MAINTAINER=	ports@MidnighBSD.org
COMMENT=	Opensource MPEG-4 codec, based on OpenDivx

LICENSE=	gpl2

USES=		gmake
GNU_CONFIGURE=	yes
MAKE_JOBS_UNSAFE=	yes
USE_LDCONFIG=	yes

CONFIGURE_ENV+=	ac_cv_prog_ac_yasm=no

PLIST_FILES=	include/xvid.h \
		lib/libxvidcore.a \
		lib/libxvidcore.so \
		lib/libxvidcore.so.4

WRKSRC=		${WRKDIR}/xvidcore/build/generic

OPTIONS_DEFINE=	OPTIMIZED_CFLAGS

.include <bsd.port.pre.mk>

.if ${ARCH} == "amd64"
CONFIGURE_TARGET=	x86_64-portbld-freebsd9.1
.endif
.if ${ARCH} == "amd64" || ${ARCH} == "i386"
BUILD_DEPENDS+=	nasm:${PORTSDIR}/devel/nasm
.endif

.if ${PORT_OPTIONS:MOPTIMIZED_CFLAGS}
CFLAGS=		# let xvid's build system decide about those
.endif

post-install:
	@ ${LN} -sf ${PREFIX}/lib/libxvidcore.so.4 ${PREFIX}/lib/libxvidcore.so

.include <bsd.port.post.mk>
