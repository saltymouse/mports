

PORTNAME=	displaycalibrator
PORTVERSION=	0.7
PORTREVISION=	1
CATEGORIES=	deskutils gnustep
MASTER_SITES=	http://gnu.ethz.ch/linuks.mine.nu/displaycalibrator/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Frontend to xgamma

LICENSE=	unknown

USES=		gnustep
USE_GNUSTEP=	back build

post-install:
	${STRIP_CMD} ${PREFIX}/GNUstep/System/Applications/DisplayCalibrator.app/DisplayCalibrator

.include <bsd.port.mk>
