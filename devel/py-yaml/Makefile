# Created by: ijliao@FreeBSD.org

PORTNAME=	yaml
PORTVERSION=	5.3.1
PORTREVISION=	1
CATEGORIES=	devel python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}
DISTNAME=	PyYAML-${PORTVERSION}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Python YAML parser

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		python:3.6+
USE_PYTHON=	autoplist concurrent distutils

OPTIONS_DEFINE=	LIBYAML EXAMPLES
OPTIONS_DEFAULT=	LIBYAML

LIBYAML_DESC=	Use textproc/libyaml for faster parsing

LIBYAML_LIB_DEPENDS=	libyaml.so:textproc/libyaml

.include <bsd.port.pre.mk>

.if ${PORT_OPTIONS:MLIBYAML}
PYDISTUTILS_SETUP+=		--with-libyaml
PYDISTUTILS_BUILD_TARGET=	build_ext
PYDISTUTILS_BUILDARGS+=		--include-dirs=${LOCALBASE}/include \
				--library-dirs=${LOCALBASE}/lib
.else
PYDISTUTILS_SETUP+=		--without-libyaml
NO_ARCH=			yes
.endif

post-install-EXAMPLES-on:
	@(cd ${WRKSRC}/examples && ${COPYTREE_SHARE} . ${FAKE_DESTDIR}${EXAMPLESDIR}/)

post-install-LIBYAML-on:
	@${STRIP_CMD} ${FAKE_DESTDIR}${PYTHONPREFIX_SITELIBDIR}/_yaml*.so

do-test:
	@cd ${WRKSRC} && ${PYTHON_CMD} ${PYDISTUTILS_SETUP} test

.include <bsd.port.post.mk>
