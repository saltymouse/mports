

PORTNAME=	xfce4-power-manager
PORTVERSION=	1.5.2
CATEGORIES=	sysutils xfce
MASTER_SITES=	XFCE/src/xfce/${PORTNAME}/${PORTVERSION:R}/
DIST_SUBDIR=	xfce4

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Power manager for the Xfce Desktop

LICENSE=	gpl2

LIB_DEPENDS=	libnotify.so:${PORTSDIR}/devel/libnotify \
	libdbus-glib-1.so:${PORTSDIR}/devel/dbus-glib \
	libpolkit-gobject-1.so:${PORTSDIR}/sysutils/polkit \
	libupower-glib.so:${PORTSDIR}/sysutils/upower

GNU_CONFIGURE=	yes
USES=		gettext gmake libtool pkgconfig tar:bzip2 xfce:gtk3
USE_GNOME=	glib20 gtk30 intltool intlhack
USE_XFCE=	panel
INSTALLS_ICONS=	yes
USE_XORG=	xrandr x11 xext xtst xscrnsaver
CONFIGURE_ARGS=	--disable-network-manager \
		--enable-polkit \
		--enable-xfce4panel
CONFIGURE_TARGET=	${ARCH}-portbld-freebsd9.1
INSTALL_TARGET=	install-strip

.include <bsd.port.mk>
