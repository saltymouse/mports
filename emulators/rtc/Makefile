

PORTNAME=	rtc
PORTVERSION=	2004.02.24.1
PORTREVISION=	9
CATEGORIES=	emulators linux
MASTER_SITES=	# none
DISTFILES=	# none

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Kernel module which provides /dev/rtc device support

LICENSE=	bsd2

WRKSRC=		${WRKDIR}/files

NO_FETCH=	yes
USES=		kmod linux uidfix

KMODDIR=	${PREFIX}/modules

CDEV_MAJOR=	202
DEVDIR=		${LINUXBASE}/dev

STARTUP=	rtc.sh
MAKE_ARGS=	KMODDIR="${KMODDIR}" CDEV_MAJOR="${CDEV_MAJOR}"
PLIST_SUB=	DEVDIR="${DEVDIR}" CDEV_MAJOR="${CDEV_MAJOR}" \
		RTC_H_DIR="${RTC_H_DIR}"

SRC_BASE?=	/usr/src

.include <bsd.port.pre.mk>

PLIST_SUB+=	MAKEDEV="@comment "

.if !exists(${SRC_BASE}/sys/Makefile)
IGNORE=		needs kernel source files
.endif

do-extract:
	@${MKDIR} ${WRKSRC}
	@${SED}	-e 's,@@PREFIX@@,${PREFIX},' \
		${FILESDIR}/${STARTUP} > ${WRKDIR}/${STARTUP}
	@cd ${FILESDIR} && ${CP} Makefile *.[ch] ${WRKSRC}/

pre-install:
	${MKDIR} ${FAKE_DESTDIR}${LOCALBASE}/modules

post-install:
	${INSTALL_DATA} ${WRKSRC}/rtc.h ${PREFIX}/include/
	${MKDIR} ${PREFIX}/share/examples/rtc
	${INSTALL_DATA} ${WRKSRC}/test.c ${PREFIX}/share/examples/rtc/
	@${ECHO} "Installing ${PREFIX}/etc/rc.d/${STARTUP} startup file.";
	${INSTALL_SCRIPT} ${WRKDIR}/${STARTUP} ${PREFIX}/etc/rc.d/

.include <bsd.port.post.mk>
