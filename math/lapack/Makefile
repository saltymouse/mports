PORTNAME?=	lapack
PORTVERSION=	3.5.0
PORTREVISION=	0
CATEGORIES=	math
MASTER_SITES=	NL/lapack/
DISTFILES=	lapack-${PORTVERSION}.tgz
.if make(makesum) || !(defined(BLAS_SLAVEPORT) || defined(XLAPACK_SLAVEPORT))
DISTFILES+=		manpages-${PORTVERSION}.tgz
.endif
DIST_SUBDIR=	lapack

MAINTAINER?=	ports@MidnightBSD.org
COMMENT?=	Library of Fortran 77 subroutines for linear algebra

LICENSE=	bsd3
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		fortran

OPTIONS_DEFINE=	PROFILE SHARED STATIC
OPTIONS_DEFAULT=	SHARED STATIC
PROFILE_DESC=	Build profiling libraries
SHARED_DESC=	Build shared libraries and PIC archives
STATIC_DESC=	Build (non-PIC) archives

MAKE_ENV=	BLASLIB="${BLASLIB}"
PLIST_SUB=	SVERSION="${SVERSION}"

WRKSRC=			${WRKDIR}/lapack-${PORTVERSION}
WRKSRC_PROFILE=		${WRKSRC}_PROFILE
WRKSRC_SHARED=		${WRKSRC}_SHARED
WRKSRC_STATIC=		${WRKSRC}

NO_TEST=	yes

.include <bsd.mport.options.mk>

.if defined(BLAS_SLAVEPORT)
ALL_TARGET=		blaslib
BLASLIB=		../../libblas.a
LIBS=			blas
PLIST_SUB+=		BLAS="" LAPACK="@comment " XLAPACK="@comment " LAPACKE="@comment "
SVERSION=		2
.elif defined(LAPACKE_SLAVEPORT)
ALL_TARGET=		lapackelib
LAPACKELIB=		liblapacke.a
LAPACKETMGLIB=		liblapacke_tmg.a
MAKE_ENV+=	LAPACKELIB="${LAPACKELIB}" LAPACKETMGLIB="${LAPACKETMGLIB}"
LIB_DEPENDS+=		libblas.so:math/blas \
			liblapack.so:math/lapack
LIBS=			lapacke lapacke_tmg
INCLS=			lapacke lapacke_utils lapacke_mangling
PLIST_SUB+=		BLAS="@comment " LAPACK="@comment " XLAPACK="@comment " LAPACKE=""
SVERSION=		1
.else
ALL_TARGET=		lib
BLASLIB?=		-L${LOCALBASE}/lib -lblas
LIB_DEPENDS+=		libblas.so:math/blas
LIBS=			lapack tmglib
SVERSION=		4
.if defined(MAINTAINER_MODE) || defined(PACKAGE_BUILDING)
S=			${PYTHON_CMD}
USES+=			python:build
.else
S=			\#
.endif
.if defined(XLAPACK_SLAVEPORT)
LIB_DEPENDS+=		libxblas.so:math/xblas
MAKE_ENV+=		USEXBLAS=yes XBLASLIB="${XBLASLIB}"
P=			x
PLIST_SUB+=		BLAS="@comment " LAPACK="@comment " XLAPACK="" LAPACKE="@comment "
XBLASLIB?=		-L${LOCALBASE}/lib -lxblas
.else
PLIST_FILES+=		${MAN3L:S|^|man/man3/|:S|$|.gz|}
PLIST_SUB+=		BLAS="@comment " LAPACK="" XLAPACK="@comment " LAPACKE="@comment "
.if defined(MAINTAINER_MODE)
BUILD_DEPENDS +=	doxygen:devel/doxygen
MAN_TARGET=		build-manpages
.endif
.endif
.endif

.if ${ARCH} == "sparc64"
PICFLAG?=	-fPIC
.else
PICFLAG?=	-fpic
.endif

FFLAGS_PROFILE?=	-pg
FFLAGS_SHARED ?=	${PICFLAG}

.if ${PORT_OPTIONS:MPROFILE}
LDFLAGS+= -static
.endif

.if ${PORT_OPTIONS:MPROFILE} && !exists(/usr/lib/libc_p.a)
IGNORE=	you have chosen WITH_PROFILE, but have not installed the\
base system profiling libraries
.endif

.if ${PORT_OPTIONS:MSHARED}
USE_LDCONFIG=	yes
.endif

.for o in PROFILE SHARED STATIC
.if ${PORT_OPTIONS:M${o}}
PLIST_SUB+=	${o}=""
.else
PLIST_SUB+=	${o}="@comment "
.endif
.endfor

post-patch:
	@${SED} -Ee '\
		s@^(FORTRAN|LOADER)([[:blank:]]*=)(.*)@\1\2 $${FC}@; \
		s@^(OPTS[[:blank:]]*=)(.*)@\1 $${FFLAGS} $${EXTRAFLAGS}@; \
		s@^NOOPT[[:blank:]]*=.*@& $${EXTRAFLAGS}@; \
		s@^(LOADOPTS[[:blank:]]*=)(.*)@\1 $${LDFLAGS} $${EXTRAFLAGS}@; \
		s@^(CC[[:blank:]]*=)(.*)@@; \
		s@^(CFLAGS[[:blank:]]*)(=)(.*)@\1 += $${EXTRAFLAGS}@; \
		\@(BLAS|LAPACKE|RAN)LIB[[:blank:]]*=@d;' \
			${WRKSRC}/make.inc.example > ${WRKSRC}/make.inc
	@${REINPLACE_CMD} -e 's@\./lapack_testing\.py@${S} &@' \
		${WRKSRC}/Makefile
.for o in PROFILE SHARED
.if ${PORT_OPTIONS:M${o}}
	@${CP} -a ${WRKSRC} ${WRKSRC_${o}}
.endif
.endfor

do-build: ${MAN_TARGET} build-profile build-shared build-static

.for o in PROFILE SHARED STATIC
build-${o:tl}: patch
.if ${PORT_OPTIONS:M${o}}
	${PRINTF} "\n\nBuilding ${o:tl} libraries:\n\n\n"
	cd ${WRKSRC_${o}}; ${SETENV} ${MAKE_ENV} EXTRAFLAGS="${FFLAGS_${o}}" \
	${MAKE} ${_MAKE_JOBS} ${MAKE_ARGS} ARCH="${AR}" ${ALL_TARGET}

.endif
.endfor

.if defined (MAINTAINER_MODE)
build-manpages: patch
	@cd ${WRKSRC}; ${SETENV} ${MAKE_ENV} ${MAKE} ${_MAKE_JOBS} \
	${MAKE_ARGS} man

.endif

post-build:
.if ${PORT_OPTIONS:MSHARED}
.for L in ${LIBS}
	cd ${WRKSRC_SHARED} ; ${FC} ${FFLAGS} ${FFLAGS_SHARED} ${LDFLAGS} -shared \
	-o lib${P}${L}.so.${SVERSION} -Wl,-x -Wl,-soname,lib${P}${L}.so.${SVERSION} \
	-Wl,--whole-archive lib${L}.a -Wl,--no-whole-archive
.endfor
.endif

do-install:
.for L in ${LIBS}
.if ${PORT_OPTIONS:MSTATIC}
	@${INSTALL_DATA} ${WRKSRC}/lib${L}.a ${STAGEDIR}${PREFIX}/lib/lib${P}${L}.a
.endif
.if ${PORT_OPTIONS:MSHARED}
	@${INSTALL_DATA} ${WRKSRC_SHARED}/lib${L}.a ${STAGEDIR}${PREFIX}/lib/lib${P}${L}_pic.a
	@${INSTALL_DATA} ${WRKSRC_SHARED}/lib${P}${L}.so.${SVERSION} ${STAGEDIR}${PREFIX}/lib
	@${LN} -sf lib${P}${L}.so.${SVERSION} ${STAGEDIR}${PREFIX}/lib/lib${P}${L}.so
.endif
.if ${PORT_OPTIONS:MPROFILE}
	@${INSTALL_DATA} ${WRKSRC_PROFILE}/lib${L}.a ${STAGEDIR}${PREFIX}/lib/lib${P}${L}_p.a
.endif
.endfor
.if defined(LAPACKE_SLAVEPORT)
.for I in ${INCLS}
	@${INSTALL_DATA} ${WRKSRC}/lapacke/include/${I}.h ${STAGEDIR}${PREFIX}/include
.endfor
.endif

.include  <bsd.port.pre.mk>

.if !(defined(BLAS_SLAVEPORT) || defined(XLAPACK_SLAVEPORT) || defined(LAPACKE_SLAVEPORT))

.include "${FILESDIR}/manpages"

post-install:
	@cd ${WRKDIR}/man ; ${ECHO_CMD} ${MAN3L:S|^|man3/|} \
	| ${XARGS} -J @ ${INSTALL_MAN} @ ${STAGEDIR}${MAN3PREFIX}/man/man3

.if defined(MAINTAINER_MODE)
package-manpages: build-manpages
	@${RM} -f ${WRKDIR}/lapack-manpages-${PORTVERSION}.tar.gz ; \
	cd ${WRKSRC}/DOCS/man; \
	${TAR} -czvf ${WRKDIR}/lapack-manpages-${PORTVERSION}.tar.gz \
	${MAN3L:S|^|man3/|}

.endif
.endif
.include <bsd.port.post.mk>
