

PORTNAME=	chroot_safe
PORTVERSION=	1.4
PORTREVISION=	2
CATEGORIES=	security sysutils
MASTER_SITES=	SF/chrootsafe/${PORTNAME}/${PORTVERSION}
EXTRACT_SUFX=	.tgz

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Tool to chroot softwares easily

LICENSE=	mit

GNU_CONFIGURE=	YES

PLIST_FILES=	sbin/chroot_safe libexec/chroot_safe/chroot_safe.so \
		man/man1/chroot_safe.1.gz
PLIST_DIRS=	libexec/chroot_safe

post-patch:
	@${REINPLACE_CMD} -e  's|CXX=g++|CXX?=c++|' \
		-e 's|-o chroot_safe.so|chroot_safe.cpp -o chroot_safe.so|' \
		${WRKSRC}/Makefile.in
	@${REINPLACE_CMD} 's|chroot(1)|chroot(8)|' ${WRKSRC}/chroot_safe.1.in
	@${REINPLACE_CMD} 's|putenv|unsetenv|' ${WRKSRC}/chroot_safe.cpp

.include <bsd.port.mk>
