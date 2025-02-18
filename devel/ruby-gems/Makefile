# Created by: Alexander Novitsky <alecn2002@yandex.ru>

PORTNAME=	gems
PORTVERSION=	3.0.8
CATEGORIES=	devel ruby
MASTER_SITES=	https://rubygems.org/rubygems/
PKGNAMEPREFIX=	${RUBY_PKGNAMEPREFIX}
DISTNAME=	rubygems-${PORTVERSION}
DIST_SUBDIR=	ruby

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Package management framework for the Ruby language

LICENSE=	mit ruby
LICENSE_COMB=	dual
LICENSE_FILE_mit=	${WRKSRC}/MIT.txt
LICENSE_FILE_ruby=	${WRKSRC}/LICENSE.txt

USES=		tar:tgz
USE_RUBY=	yes

GEMS_BASE_DIR=	lib/ruby/gems/${RUBY_VER}
GEMS_ENV=	DONT_USE_BUNDLER_FOR_GEMDEPS=true GEM_HOME=${FAKE_DESTDIR}${TRUE_PREFIX}/${GEMS_BASE_DIR}
NO_ARCH=	yes
NO_BUILD=	yes
RUBY_SETUP=	setup.rb
RUBY_SETUP_OPTIONS=	--destdir=${FAKE_DESTDIR} --no-regenerate-binstubs
RUBY_VER_SHORT=            ${RUBY_VER:S/.//}

CACHE_DIR=	${GEMS_BASE_DIR}/cache
DOC_DIR=	${GEMS_BASE_DIR}/doc
EXT_DIR=	${GEMS_BASE_DIR}/extensions
GEMS_DIR=	${GEMS_BASE_DIR}/gems
SPEC_DIR=	${GEMS_BASE_DIR}/specifications

PLIST_SUB=	GEMS_DIR="${GEMS_DIR}" \
		DOC_DIR="${DOC_DIR}" \
		CACHE_DIR="${CACHE_DIR}" \
		SPEC_DIR="${SPEC_DIR}" \
		EXT_DIR="${EXT_DIR}"

OPTIONS_DEFINE=	DOCS

DOCS_VARS_OFF=	RUBY_SETUP_OPTIONS+="--no-ri --no-rdoc"

pre-fake:
	${LN} -sf /usr/local/bin/ruby${RUBY_VER_SHORT} ${FAKE_DESTDIR}${TRUE_PREFIX}/bin/
	${LN} -sf gem${RUBY_VER_SHORT} ${FAKE_DESTDIR}${TRUE_PREFIX}/bin/gem

do-install:
	${MKDIR} ${STAGEDIR}${PREFIX}/${GEMS_BASE_DIR}
	${MKDIR} ${STAGEDIR}${PREFIX}/${GEMS_BASE_DIR}/build_info
	${MKDIR} ${STAGEDIR}${PREFIX}/${CACHE_DIR}
	${MKDIR} ${STAGEDIR}${PREFIX}/${DOC_DIR}
	${MKDIR} ${STAGEDIR}${PREFIX}/${EXT_DIR}
	${MKDIR} ${STAGEDIR}${PREFIX}/${GEMS_DIR}
	${MKDIR} ${STAGEDIR}${PREFIX}/${SPEC_DIR}
	cd ${WRKSRC}/ && ${SETENV} ${GEMS_ENV} ${RUBY} ${RUBY_SETUP} ${RUBY_SETUP_OPTIONS}
	${INSTALL_SCRIPT} ${WRKSRC}/bin/gem ${PREFIX}/bin/gem${RUBY_VER_SHORT}
	${LN} -sf gem${RUBY_SUFFIX} ${STAGEDIR}${PREFIX}/bin/gem

# Find all RDOC and RI files
post-install-DOCS-on:
	cd ${FAKE_DESTDIR}${TRUE_PREFIX}/ && ${FIND} -ds ${DOC_DIR}/ ! -type d >> ${TMPPLIST}

.include <bsd.port.mk>
