PORTNAME=	formats
PORTVERSION=	20150521
PORTREVISION=	2
CATEGORIES=	print
MASTER_SITES=	#empty
PKGNAMEPREFIX=	tex-
DISTFILES=	#empty
EXTRACT_ONLY=	#empty

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Formats for Basic TeX engines and the latex command

LICENSE=	unknown

USE_TEX=	web2c basic texmf fmtutil texhash
TEXHASHDIRS=	${TEXMFVARDIR}
TEX_FORMATS=	amstex context cslatex csplain eplain latex-bin \
		metafont mex mptopdf pdftex tex

NO_BUILD=	yes

post-extract:
	mkdir ${WRKSRC}
	mkdir ${FAKE_DESTDIR}

do-install: do-texhash do-fmtutil

.include <bsd.port.mk>
