PORTNAME=	docutils
PORTVERSION=	0.17.1
CATEGORIES=	textproc python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Python Documentation Utilities

LICENSE=	bsd2 gpl3 publicdom python
LICENSE_COMB=	multi

PORTSCOUT=	limit:^[0-9\.]*$$

NO_ARCH=	yes
USE_PYTHON=	autoplist concurrent distutils
USES=		python:3.6+

OPTIONS_DEFINE=	PYGMENTS
PYGMENTS_DESC=	Syntax highlighting
PYGMENTS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}pygments>=1.6:textproc/py-pygments@${PY_FLAVOR}

SCRIPTS=	rst2html rst2latex rst2man rst2odt rst2odt_prepstyles \
		rst2pseudoxml rst2s5 rst2xetex rst2xml rstpep2html

post-install:
.for script in ${SCRIPTS}
	${LN} -s ${script}.py-${PYTHON_VER} ${STAGEDIR}${PREFIX}/bin/${script}
.endfor

.include <bsd.port.mk>
