PORTNAME=	wayland-protocols
PORTVERSION=	1.23
CATEGORIES=	graphics wayland
MASTER_SITES=	https://wayland.freedesktop.org/releases/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Wayland protocols

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/COPYING

BUILD_DEPENDS=	wayland-scanner:graphics/wayland

USES=		autoreconf pkgconfig tar:xz
NO_ARCH=	yes
GNU_CONFIGURE=	yes
CONFIGURE_ARGS=	--with-noarch-pkgconfigdir='$${prefix}/libdata/pkgconfig'
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd11.4

.include <bsd.port.mk>
