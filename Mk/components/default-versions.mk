# Provide default versions for ports with multiple versions selectable
# by the user.
#
# Users who want to override these defaults can easily do so by defining
# DEFAULT_VERSIONS in their make.conf as follows:
#
#   DEFAULT_VERSIONS=	perl5=5.18 ruby=2.0

.if !defined(_INCLUDE_BSD_DEFAULT_VERSIONS_MK)
_INCLUDE_BSD_DEFAULT_VERSIONS_MK=	yes

LOCALBASE?=	/usr/local
MPORT_CMD?=	/usr/sbin/mport

.for lang in APACHE BDB EMACS FIREBIRD FORTRAN FPC GCC GHOSTSCRIPT LINUX LUA \
	MYSQL PERL5 PGSQL PHP PYTHON PYTHON2 PYTHON3 RUBY SSL TCLTK
.if defined(${lang}_DEFAULT)
ERROR+=	"The variable ${lang}_DEFAULT is set and it should only be defined through DEFAULT_VERSIONS+=${lang:tl}=${${lang}_DEFAULT} in /etc/make.conf"
.endif
#.undef ${lang}_DEFAULT
.endfor

.for lang in ${DEFAULT_VERSIONS}
_l=		${lang:C/=.*//g}
${_l:tu}_DEFAULT=	${lang:C/.*=//g}
.endfor

# Possible values: 2.4
APACHE_DEFAULT?=	2.4
# Possible values: 48, 5, 6
BDB_DEFAULT?=		5
# Possible_values: full canna nox devel_full devel_nox
#EMACS_DEFAULT?=	let the flavor be the default if not explicitly set
# Possible values: 2.5
FIREBIRD_DEFAULT?=	2.5
# Possible values: flang (experimental), gfortran
FORTRAN_DEFAULT?=	gfortran
# Possible values: 3.0.4
FPC_DEFAULT?=		3.0.4
# Possible values: 4.9, 5, 6, 7
GCC_DEFAULT?=		8
GHOSTSCRIPT_DEFAULT?=	9
# Possible values: c7
LINUX_DEFAULT?=		c7
LLVM_DEFAULT?=		70
LUA_DEFAULT?=		5.2
MYSQL_DEFAULT?=		5.7
NINJA_DEFAULT?=		ninja
.if ${OSVERSION} < 200001
PERL5_DEFAULT?=		5.28
.else
PERL5_DEFAULT?=		5.32
.endif
PGSQL_DEFAULT?=		11
PHP_DEFAULT?=		7.4
PYTHON_DEFAULT?=	3.8
PYTHON2_DEFAULT?=	2.7
# Possible values: 3.7, 3.8, 3.9
PYTHON3_DEFAULT?=	3.8
# Possible values: 2.6, 2.7, 3.0
RUBY_DEFAULT?=		2.7
# Possible values: rust, rust-bin
RUST_DEFAULT?=		rust
# Possible values: 4.13
SAMBA_DEFAULT?=		4.13
# Possible values: base, openssl, libressl, libressl-devel
.if !defined(SSL_DEFAULT)
#	If no preference was set, check for an installed base version
#	but give an installed port preference over it.
.  if	!defined(SSL_DEFAULT) && \
	!exists(${LOCALBASE}/lib/libcrypto.so) && \
	exists(/usr/include/openssl/opensslv.h)
SSL_DEFAULT=	base
.  else
.    if exists(${LOCALBASE}/lib/libcrypto.so)
.      if defined(MPORT_CMD)
# find installed port and use it for dependency
.        if !defined(OPENSSL_INSTALLED)
OPENSSL_INSTALLED!=	${MPORT_CMD} which -qo ${LOCALBASE}/lib/libcrypto.so || :
.        endif
.        if defined(OPENSSL_INSTALLED) && !empty(OPENSSL_INSTALLED)
SSL_DEFAULT:=		${OPENSSL_INSTALLED:T}
WARNING+=	"You have ${OPENSSL_INSTALLED} installed but do not have DEFAULT_VERSIONS+=ssl=${SSL_DEFAULT} set in your make.conf"
.        endif
.      else
check-makevars::
	@${ECHO_MSG} "You have a ${LOCALBASE}/lib/libcrypto.so file installed, but the framework is unable"
	@${ECHO_MSG} "to determine what port it comes from."
	@${ECHO_MSG} "Add DEFAULT_VERSIONS+=ssl=<openssl package name> to your /etc/make.conf and try again."
	@${FALSE}
.      endif
.    endif
.  endif
# Make sure we have a default in the end
SSL_DEFAULT?=	base
.endif
# Possible values: 8.5, 8.6, 8.7
TCLTK_DEFAULT?=		8.6

# Possible values: 4, 5
VARNISH_DEFAULT?=	4

.endif
