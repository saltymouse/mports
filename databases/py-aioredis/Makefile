# Created by: Babak Farrokhi <farrokhi@FreeBSD.org>

PORTNAME=	aioredis
PORTVERSION=	1.3.1
CATEGORIES=	databases python
MASTER_SITES=	CHEESESHOP
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Python asyncio (PEP 3156) Redis client library

LICENSE=	mit
LICENSE_FILE=	${WRKSRC}/LICENSE

RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}async_timeout>0:devel/py-async_timeout@${PY_FLAVOR}

USES=		python:3.5+
USE_PYTHON=	distutils autoplist

OPTIONS_DEFINE=	HIREDIS

HIREDIS_DESC=	High performance response parser (via hiredis)

HIREDIS_RUN_DEPENDS=	${PYTHON_PKGNAMEPREFIX}hiredis>0:databases/py-hiredis@${PY_FLAVOR}

.include <bsd.port.mk>
