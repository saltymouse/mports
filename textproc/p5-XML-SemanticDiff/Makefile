PORTNAME=	XML-SemanticDiff
PORTVERSION=	1.0007
CATEGORIES=	textproc perl5
MASTER_SITES=	CPAN
PKGNAMEPREFIX=	p5-

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Perl extension for comparing XML documents

LICENSE=	artistic gpl
LICENSE_COMB=	dual
LICENSE_FILE_ART10=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${RUN_DEPENDS}
RUN_DEPENDS=	p5-XML-Parser>=0:textproc/p5-XML-Parser

NO_ARCH=	yes
NO_TEST=	yes
USES=		perl5
USE_PERL5=	modbuild

.include <bsd.port.mk>
