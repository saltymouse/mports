# Created by: Tobias Kortkamp <t@tobik.me>

PORTNAME=	sndio
PORTVERSION=	1.6.0
CATEGORIES=	audio
MASTER_SITES=	http://www.sndio.org/

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Small audio and MIDI framework from the OpenBSD project

LICENSE=	iscl

USE_LDCONFIG=	yes
USE_RC_SUBR=	sndiod

HAS_CONFIGURE=	yes
CONFIGURE_ARGS=	--mandir=${PREFIX}/man \
		--prefix=${PREFIX}

# Parallel build leads to problems, but sndio is very quick to compile
# as is so not worth fixing
MAKE_JOBS_UNSAFE=	yes

USERS=		_sndio
GROUPS=		_sndio

post-patch:
# Make sure sndiod can be started inside jails as root
	@${REINPLACE_CMD} 's|err(1, "setpriority")|warn("setpriority")|' \
		${WRKSRC}/sndiod/sndiod.c

post-install:
	@${STRIP_CMD} \
		${STAGEDIR}${PREFIX}/lib/libsndio.so.6.1 \
		${STAGEDIR}${PREFIX}/bin/sndiod \
		${STAGEDIR}${PREFIX}/bin/aucat \
		${STAGEDIR}${PREFIX}/bin/midicat

.include <bsd.port.mk>
