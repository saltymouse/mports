PORTNAME=	game
DISTVERSION=	2.0.1
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	py${PORTNAME}-${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Module designed to write games in Python

LICENSE=	lgpl2.1
LICENSE_FILE=	${WRKSRC}/docs/LGPL.txt

BUILD_DEPENDS=	v4l_compat>0:multimedia/v4l_compat
LIB_DEPENDS=	libfreetype.so:print/freetype2 \
		libpng.so:graphics/png \
		libsmpeg.so:multimedia/smpeg
RUN_DEPENDS=	${PYNUMPY} \
		v4l_compat>0:multimedia/v4l_compat

USES=		compiler:c11 jpeg pkgconfig python:3.6+ sdl xorg
USE_SDL=	sdl2 ttf2 image2 mixer2
USE_PYTHON=	autoplist distutils
USE_XORG=	x11

SDLNOX11=	sdl-nox11-[0-9]*

DOCSDIR=	${PREFIX}/share/doc/py-${PORTNAME}
EXAMPLESDIR=	${PREFIX}/share/examples/py-${PORTNAME}

OPTIONS_DEFINE=	DOCS EXAMPLES

PORTDOCS=	*
PORTEXAMPLES=	*

NO_TEST=	yes

post-extract:
	@${RM} -r ${WRKSRC}/examples/.editorconfig

post-install-EXAMPLES-on:
	@${MKDIR} ${FAKE_DESTDIR}${EXAMPLESDIR}

#Remove Un-needed macosx files
	-${RM} -r ${WRKSRC}/examples/macosx
	${TAR} -C ${WRKSRC}/examples -cf - . | \
		${TAR} --unlink -C ${FAKE_DESTDIR}${EXAMPLESDIR} -xf -

post-install-DOCS-on:
	@${MKDIR} ${FAKE_DESTDIR}${DOCSDIR}
	${TAR} -C ${WRKSRC}/docs -cf - . | \
	${TAR} --unlink -C ${FAKE_DESTDIR}${DOCSDIR} -xf -

post-install:
	${STRIP_CMD} ${FAKE_DESTDIR}${PYTHON_SITELIBDIR}/pygame/*.so
	${STRIP_CMD} ${FAKE_DESTDIR}${PYTHON_SITELIBDIR}/pygame/_sdl2/*.so

.include <bsd.port.mk>
