PORTNAME=	gnupg
PORTVERSION=	2.2.18
CATEGORIES=	security
MASTER_SITES=	GNUPG

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	Complete and free PGP implementation

LICENSE=	gpl3 lgpl3
LICENSE_COMB=	multi
LICENSE_FILE_gpl3=	${WRKSRC}/COPYING
LICENSE_FILE_lgpl3=	${WRKSRC}/COPYING.LGPL3

LIB_DEPENDS=	libassuan.so:security/libassuan \
		libgcrypt.so:security/libgcrypt \
		libgpg-error.so:security/libgpg-error \
		libksba.so:security/libksba \
		libnpth.so:devel/npth
BUILD_DEPENDS=	libassuan>=2.5.1:security/libassuan \
		libgpg-error>=1.16:security/libgpg-error
RUN_DEPENDS=	pinentry:security/pinentry

CONFLICTS=	gnupg-2.0.* dirmngr-[0-9]*
CPE_VENDOR=	gnupg

USES=		compiler:c11 cpe gmake iconv pkgconfig readline sqlite tar:bzip2
CONFIGURE_ARGS=	--disable-ntbtls --disable-wks-tools \
		--enable-gpg-is-gpg2 --enable-symcryptrun --disable-scdaemon
GNU_CONFIGURE=	yes
USE_LDCONFIG=	yes
INFO=		gnupg
TEST_TARGET=	check

OPTIONS_DEFINE=	GNUTLS LDAP NLS DOCS SUID_GPG
OPTIONS_DEFAULT=GNUTLS 
NO_OPTIONS_SORT=yes
OPTIONS_SUB=	yes

LDAP_DESC=	LDAP keyserver interface
SUID_GPG_DESC=	Install GPG with suid
# In jail, SUID is required to avoid warning
# (security.bsd.unprivileged_mlock sysctl is not used in jail).

GNUTLS_CONFIGURE_ENABLE=gnutls
GNUTLS_LIB_DEPENDS=	libgnutls.so:security/gnutls

LDAP_CONFIGURE_WITH=	ldap=${LOCALBASE}
LDAP_LIBS=		-L${LOCALBASE}/lib
LDAP_USE=		OPENLDAP=yes
LDAP_USES=		readline

NLS_CONFIGURE_ENABLE=	nls
NLS_USES=		gettext

post-install:
	@${MV} ${STAGEDIR}${DATADIR}/help*.txt ${STAGEDIR}${DOCSDIR}

.include <bsd.port.mk>
