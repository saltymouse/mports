PORTNAME=	aom
DISTVERSIONPREFIX=	v
DISTVERSION=	3.1.2
PORTREVISION=	1
CATEGORIES=	multimedia

MAINTAINER=	ports@MidnightBSD.org
COMMENT=	AV1 reference encoder/decoder

LICENSE=	bsd2
LICENSE_FILE=	${WRKSRC}/LICENSE

BUILD_DEPENDS=	${BUILD_DEPENDS_${ARCH}}
BUILD_DEPENDS_amd64=	yasm:devel/yasm
BUILD_DEPENDS_i386=	yasm:devel/yasm

USES=		cmake compiler:c++11-lib perl5 pkgconfig
USE_GITHUB=	yes
USE_PERL5=	build
USE_LDCONFIG=	yes
GH_ACCOUNT=	jbeich # mirror
CMAKE_ON=	BUILD_SHARED_LIBS
CMAKE_OFF=	ENABLE_DOCS ENABLE_TESTS

OPTIONS_DEFINE=	VMAF

VMAF_DESC=		Encoding tuning for VMAF
VMAF_LIB_DEPENDS=	libvmaf.so:multimedia/vmaf
VMAF_USES=		localbase:ldflags
VMAF_CMAKE_ON=		-DCONFIG_TUNE_VMAF:STRING=1

post-patch:
# Extract (snapshot) version from the port instead of CHANGELOG
	@${REINPLACE_CMD} 's,$${AOM_ROOT}/CHANGELOG,${DISTVERSIONFULL:S/^v//},' \
		${WRKSRC}/build/cmake/version.cmake

post-install:
	cd ${PREFIX}/lib && ${LN} -sf libaom.so.3 libaom.so.2

.include <bsd.port.mk>
