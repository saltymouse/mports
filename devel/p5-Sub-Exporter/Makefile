# Created by: Lars Balker Rasmussen <lbr@FreeBSD.org>

PORTNAME=	Sub-Exporter
PORTVERSION=	0.987
PORTREVISION=	1
CATEGORIES=	devel perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Sophisticated exporter for custom-built routines

LICENSE=	artistic gpl
LICENSE_COMB=	dual

BUILD_DEPENDS=	${RUN_DEPENDS}
RUN_DEPENDS=	p5-Data-OptList>=0.100:devel/p5-Data-OptList \
		p5-Params-Util>=0.14:devel/p5-Params-Util \
		p5-Sub-Install>=0.920:devel/p5-Sub-Install

USES=		perl5
USE_PERL5=	configure

.include <bsd.port.mk>
