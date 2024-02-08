
AC_PREREQ([2.67])
AC_INIT(mpdecimal, 2.5.1, mpdecimal-bugs@bytereef.org, mpdecimal, http://www.bytereef.org/mpdecimal/index.html)
AC_CONFIG_HEADER(config.h)
AC_CONFIG_FILES([Makefile libmpdec/Makefile tests/Makefile libmpdec/mpdecimal.h libmpdec++/Makefile tests++/Makefile])
AC_ARG_VAR(MACHINE, [force configuration: x64, uint128, ansi64, ppro, ansi32, ansi-legacy, universal])


# System and machine type (only used for Solaris, Darwin, BSD and AIX):
AC_MSG_CHECKING(system as reported by uname -s)
ac_sys_system=`uname -s`
AC_MSG_RESULT($ac_sys_system)

# Values for the MPD_HEADER_CONFIG variable:
CONFIG_64="
/* ABI: 64-bit */
#define MPD_CONFIG_64 1

#ifdef MPD_CONFIG_32
  #error \"cannot use MPD_CONFIG_32 with 64-bit header.\"
#endif

#ifdef CONFIG_32
  #error \"cannot use CONFIG_32 with 64-bit header.\"
#endif"

CONFIG_32="
/* ABI: 32-bit */
#define MPD_CONFIG_32 1

#ifdef MPD_CONFIG_64
  #error \"cannot use MPD_CONFIG_64 with 32-bit header.\"
#endif

#ifdef CONFIG_64
  #error \"cannot use CONFIG_64 with 32-bit header.\"
#endif"

CONFIG_32_LEGACY="
/* ABI: 32-bit */
#define MPD_CONFIG_32 1

/* libmpdec was compiled without support for int64_t */
#define MPD_LEGACY_COMPILER 1

#ifdef MPD_CONFIG_64
  #error \"cannot use MPD_CONFIG_64 with 32-bit header.\"
#endif

#ifdef CONFIG_64
  #error \"cannot use CONFIG_64 with 32-bit header.\"
#endif"

CONFIG_UNIVERSAL="
/* Mac OS X: support for building universal binaries */
#if defined(MPD_CONFIG_64) || defined(MPD_CONFIG_32)
  #error \"cannot use MPD_CONFIG_64 or MPD_CONFIG_32 with universal header.\"
#endif

#if defined(CONFIG_64) || defined(CONFIG_32)
  #error \"cannot use CONFIG_64 or CONFIG_32 with universal header.\"
#endif

#if defined(__ppc__)
  #define MPD_CONFIG_32 1
  #ifdef UNIVERSAL
    #define CONFIG_32
    #define ANSI
  #endif
#elif defined(__ppc64__)
  #define MPD_CONFIG_64 1
  #ifdef UNIVERSAL
    #define CONFIG_64
    #define ANSI
  #endif
#elif defined(__i386__)
  #define MPD_CONFIG_32 1
  #ifdef UNIVERSAL
    #define CONFIG_32
    #define ANSI
  #endif
#elif defined(__x86_64__)
  #define MPD_CONFIG_64 1
  #ifdef UNIVERSAL
    #define CONFIG_64
    #define ASM
  #endif
#elif defined(__arm64__)
  #define MPD_CONFIG_64 1
  #ifdef UNIVERSAL
    #define CONFIG_64
    #define ANSI
  #endif
#else
  #error \"unknown architecture for universal build.\"
#endif"

CONFIG_UNIVERSAL_AIX_GCC="
/* AIX: support for multilib */
#if defined(MPD_CONFIG_64) || defined(MPD_CONFIG_32)
  #error \"cannot use MPD_CONFIG_64 or MPD_CONFIG_32 with multilib header.\"
#endif

#if defined(CONFIG_64) || defined(CONFIG_32)
  #error \"cannot use CONFIG_64 or CONFIG_32 with multilib header.\"
#endif

#if defined(__64BIT__)
  #define MPD_CONFIG_64 1
  #ifdef UNIVERSAL
    #define CONFIG_64
    #define ANSI
    #define HAVE_UINT128_T
  #endif
#else
  #define MPD_CONFIG_32 1
  #ifdef UNIVERSAL
    #define CONFIG_32
    #define ANSI
  #endif
#endif"

CONFIG_UNIVERSAL_AIX_XLC="
/* AIX: support for multilib */
#if defined(MPD_CONFIG_64) || defined(MPD_CONFIG_32)
  #error \"cannot use MPD_CONFIG_64 or MPD_CONFIG_32 with multilib header.\"
#endif

#if defined(CONFIG_64) || defined(CONFIG_32)
  #error \"cannot use CONFIG_64 or CONFIG_32 with multilib header.\"
#endif

#if defined(__64BIT__)
  #define MPD_CONFIG_64 1
  #ifdef UNIVERSAL
    #define CONFIG_64
    #define ANSI
  #endif
#else
  #define MPD_CONFIG_32 1
  #ifdef UNIVERSAL
    #define CONFIG_32
    #define ANSI
  #endif
#endif"

# Detect explicit 64-bit or 32-bit build:
M64=
M32=
INITIAL_CFLAGS="$CFLAGS"
INITIAL_CXXFLAGS="$CXXFLAGS"
INITIAL_LDFLAGS="$LDFLAGS"
INITIAL_LDXXFLAGS="$LDXXFLAGS"
if test -n "$MACHINE"; then
    case $ac_sys_system in
        AIX)
            case $CC in
            *xlc*)
                M64="-q64"
                M32="-q32"
                ;;
            *)
                M64="-maix64"
                M32="-maix32"
                ;;
            esac
            ;;
        *)
            M64="-m64"
            M32="-m32"
            ;;
    esac

    case "$MACHINE" in
        x64|uint128|ansi64)
            CFLAGS="$CFLAGS $M64"
            CXXFLAGS="$CXXFLAGS $M64"
            LDFLAGS="$LDFLAGS $M64"
            LDXXFLAGS="$LDXXFLAGS $M64"
            ;;
        ppro|ansi32|ansi-legacy)
            CFLAGS="$CFLAGS $M32"
            CXXFLAGS="$CXXFLAGS $M32"
            LDFLAGS="$LDFLAGS $M32"
            LDXXFLAGS="$LDXXFLAGS $M32"
            ;;
        universal)
            :
            ;;
        *)
            echo "configure: error: invalid MACHINE variable: $MACHINE"
            exit 1
            ;;
    esac
fi

# Set library names and linker flags:
LIBSTATIC=libmpdec.a
LIBSHARED_USE_AR="no"
LIBIMPORT=
LINK_STATIC=
LINK_DYNAMIC=
LINK_SHLIBS="-lmpdec"
case $ac_sys_system in
    darwin*|Darwin*)
        LIBNAME="libmpdec.dylib"
        LIBSONAME="libmpdec.3.dylib"
        LIBSHARED="libmpdec.2.5.1.dylib"
        CONFIGURE_LDFLAGS="-dynamiclib -install_name @rpath/$LIBSONAME -compatibility_version 2.5 -current_version 2.5.1"
        ;;
    AIX)
        LIBNAME="libmpdec.so"
        LIBSONAME="libmpdec.so.3"
        LIBSHARED="shr.o"
        LIBIMPORT="libmpdec.imp"
        LIBSHARED_USE_AR="yes"
        CONFIGURE_LDFLAGS="-shared -Wl,-bnoentry -Wl,-bE:.objs/symbols.exp"
        LINK_STATIC="-Wl,-bstatic"
        LINK_DYNAMIC="-Wl,-bshared"
        LINK_SHLIBS="../libmpdec/$LIBIMPORT"
        ;;
    *)
        LIBNAME="libmpdec.so"
        LIBSONAME="libmpdec.so.3"
        LIBSHARED="libmpdec.so.2.5.1"
        CONFIGURE_LDFLAGS="-shared -Wl,-soname,$LIBSONAME"
        ;;
esac

LIBSTATIC_CXX=libmpdec++.a
LINK_SHLIBS_CXX="-lmpdec++"
case $ac_sys_system in
    darwin*|Darwin*)
        LIBNAME_CXX="libmpdec++.dylib"
        LIBSONAME_CXX="libmpdec++.3.dylib"
        LIBSHARED_CXX="libmpdec++.2.5.1.dylib"
        CONFIGURE_LDXXFLAGS="-dynamiclib -install_name @rpath/$LIBSONAME_CXX -undefined dynamic_lookup -compatibility_version 2.5 -current_version 2.5.1"
        ;;
    AIX)
        LIBNAME_CXX="libmpdec++.so"
        LIBSONAME_CXX="libmpdec++.so.3"
        LIBSHARED_CXX="shr.o"
        CONFIGURE_LDXXFLAGS="-shared -Wl,-bnoentry -Wl,-bE:.objs/symbols.exp"
        ;;
    *)
        LIBNAME_CXX="libmpdec++.so"
        LIBSONAME_CXX="libmpdec++.so.3"
        LIBSHARED_CXX="libmpdec++.so.2.5.1"
        CONFIGURE_LDXXFLAGS="-shared -Wl,-soname,$LIBSONAME_CXX"
        ;;
esac

AC_SUBST(LIBSTATIC)
AC_SUBST(LIBNAME)
AC_SUBST(LIBSONAME)
AC_SUBST(LIBSHARED)
AC_SUBST(LIBIMPORT)
AC_SUBST(LIBSHARED_USE_AR)
AC_SUBST(LINK_STATIC)
AC_SUBST(LINK_DYNAMIC)
AC_SUBST(LINK_SHLIBS)

AC_SUBST(LIBSTATIC_CXX)
AC_SUBST(LIBNAME_CXX)
AC_SUBST(LIBSONAME_CXX)
AC_SUBST(LIBSHARED_CXX)
AC_SUBST(LINK_SHLIBS_CXX)

# Apparently purely informational for this particular build:
AC_CANONICAL_HOST
AC_SUBST(build)
AC_SUBST(host)

# Check whether to build the shared libraries:
AC_MSG_CHECKING(for --enable-shared)
AC_ARG_ENABLE(shared,
              AS_HELP_STRING([--enable-shared], [enable building shared libraries (default is yes)]))

ENABLE_SHARED="$enable_shared"
if test -z "$ENABLE_SHARED"
then
    ENABLE_SHARED="yes"
fi
AC_MSG_RESULT($ENABLE_SHARED)

# Check whether to build libmpdec++:
AC_MSG_CHECKING(for --enable-cxx)
AC_ARG_ENABLE(cxx,
              AS_HELP_STRING([--enable-cxx], [enable building libmpdec++ (default is yes)]))

ENABLE_CXX="$enable_cxx"
if test -z "$ENABLE_CXX"
then
    if test x"$MACHINE" = x"ansi-legacy"; then
        ENABLE_CXX="no"
    else
        ENABLE_CXX="yes"
    fi
fi
AC_MSG_RESULT($ENABLE_CXX)

# Check whether to build using PGO:
AC_MSG_CHECKING(for --enable-profile)
AC_ARG_ENABLE(profile,
              AS_HELP_STRING([--enable-profile], [enable profile-guided optimization (default is no)]))

PROFILE="$enable_profile"
if test -z "$PROFILE"
then
    PROFILE="no"
fi
AC_MSG_RESULT($PROFILE)

if test x"$PROFILE" = x"yes"; then
    PROFILE="profile"
else
    PROFILE=
fi

# Language and compiler:
AC_LANG_C
saved_cflags="$CFLAGS"
saved_ldflags="$LDFLAGS"
AC_PROG_CC
CFLAGS="$saved_cflags"
LDFLAGS="$saved_ldflags"

if test x"$ENABLE_CXX" = x"yes"; then
    saved_cxxflags="$CXXFLAGS"
    saved_ldxxflags="$LDXXFLAGS"
    AC_PROG_CXX
    CXXFLAGS="$saved_cxxflags"
    LDXXFLAGS="$saved_ldxxflags"
fi

# ar and ranlib:
AC_CHECK_TOOL(AR, ar, ar)
AC_PROG_RANLIB

# Checks for header files:
AC_HEADER_STDC
AC_CHECK_HEADERS(inttypes.h pthread.h stdint.h)

# Type availability checks:
AC_TYPE_SIZE_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_CHECK_TYPE(__uint128_t, AC_DEFINE(HAVE_UINT128_T, 1,
              [Define if your compiler provides __uint128_t.]),,)

# Sizes of various types:
AC_CHECK_SIZEOF(size_t, 4)
AC_CHECK_SIZEOF(__uint128_t, 16)

# x64 with gcc asm:
AC_MSG_CHECKING(for x64 gcc inline assembler)
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[
  __asm__ __volatile__ ("movq %rcx, %rax");
]])],[have_gcc_asm_for_x64=yes],[have_gcc_asm_for_x64=no])
AC_MSG_RESULT($have_gcc_asm_for_x64)
if test "$have_gcc_asm_for_x64" = yes; then
    AC_DEFINE(HAVE_GCC_ASM_FOR_X64, 1,
    [Define if we can use x64 gcc inline assembler.])
fi

# x87 with gcc asm:
AC_MSG_CHECKING(for x87 gcc inline assembler)
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[
  unsigned short cw;
  __asm__ __volatile__ ("fnstcw %0" : "=m" (cw));
  __asm__ __volatile__ ("fldcw %0" : : "m" (cw));
]])],[have_gcc_asm_for_x87=yes],[have_gcc_asm_for_x87=no])
AC_MSG_RESULT($have_gcc_asm_for_x87)
if test "$have_gcc_asm_for_x87" = yes; then
    AC_DEFINE(HAVE_GCC_ASM_FOR_X87, 1,
    [Define if we can use x87 gcc inline assembler.])
fi

# Availability of -O2:
AC_MSG_CHECKING(for -O2)
saved_cflags="$CFLAGS"
saved_ldflags="$LDFLAGS"
CFLAGS="-O2"
LDFLAGS=
AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[]], [[
]])],[have_O2=yes],[have_O2=no])
AC_MSG_RESULT($have_O2)
CFLAGS="$saved_cflags"
LDFLAGS="$saved_ldflags"

# Install program:
AC_PROG_INSTALL
AC_SUBST(INSTALL)

# _FORTIFY_SOURCE wrappers for memmove and bcopy are incorrect:
# http://sourceware.org/ml/libc-alpha/2010-12/msg00009.html
AC_MSG_CHECKING(for glibc _FORTIFY_SOURCE/memmove bug)
saved_cflags="$CFLAGS"
saved_ldflags="$LDFLAGS"
CFLAGS="-O2 -D_FORTIFY_SOURCE=2"
if test "$have_O2" = no; then
    CFLAGS=
fi
LDFLAGS=
AC_RUN_IFELSE([AC_LANG_SOURCE([[
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
void foo(void *p, void *q) { memmove(p, q, 19); }
int main() {
  char a[32] = "123456789000000000";
  foo(&a[9], a);
  if (strcmp(a, "123456789123456789000000000") != 0)
    return 1;
  foo(a, &a[9]);
  if (strcmp(a, "123456789000000000") != 0)
    return 1;
  return 0;
}
]])],
[have_glibc_memmove_bug=no],
[have_glibc_memmove_bug=yes],
[have_glibc_memmove_bug=undefined])
CFLAGS="$saved_cflags"
LDFLAGS="$saved_ldflags"
AC_MSG_RESULT($have_glibc_memmove_bug)
if test "$have_glibc_memmove_bug" = yes; then
    AC_DEFINE(HAVE_GLIBC_MEMMOVE_BUG, 1,
    [Define if glibc has incorrect _FORTIFY_SOURCE wrappers
     for memmove and bcopy.])
fi

# BSD and Solaris fixes:
MPD_GNU99=
case $ac_sys_system in
OpenBSD|FreeBSD)
    case $CC in
        cc)
            CC=clang
            CXX=clang++
            ;;
    esac
    ;;
sun*|Sun*)
    case $CC in
        *gcc*)
            MPD_GNU99=-std=gnu99
            ;;
        cc)
            CC=suncc
            ;;
    esac
    ;;
esac

# Compiler dependent settings:
MPD_PTHREAD=
MPD_WARN=
MPD_WARNXX=
MPD_OPT="-O2"
MPD_PGEN=
MPD_PUSE=
CONFIG_UNIVERSAL_AIX=
case $CC in
    *gcc*)
        CONFIG_UNIVERSAL_AIX=$CONFIG_UNIVERSAL_AIX_GCC
        MPD_PTHREAD="-pthread"
        MPD_WARN="-Wall -Wextra -Wno-unknown-pragmas -std=c99 -pedantic"
        MPD_WARNXX="-Wall -Wextra -std=c++11 -pedantic"
        MPD_OPT="-DNDEBUG -O2"
        MPD_PGEN="-fprofile-generate -fprofile-values"
        MPD_PUSE="-fprofile-use -freorder-blocks"
        ;;
    *icc*)
        AR=xiar
        LD="$CC"
        CXX=icpc
        LDXX=icpc
        MPD_PTHREAD="-pthread"
        MPD_WARN="-Wall -Wextra -Wno-unknown-pragmas -std=c99 -pedantic -diag-disable=11074,11076"
        MPD_WARNXX="-Wall -Wextra -std=c++11 -pedantic -diag-disable=11074,11076"
        MPD_OPT="-DNDEBUG -O2"
        MPD_PGEN="-wd11505 -prof-gen"
        MPD_PUSE="-wd11505 -prof-use"
        ;;
    *clang*)
        MPD_PTHREAD="-pthread"
        MPD_WARN="-Wall -Wextra -Wno-unknown-pragmas -std=c99 -pedantic"
        MPD_WARNXX="-Wall -Wextra -Wexit-time-destructors -std=c++11 -pedantic"
        MPD_OPT="-DNDEBUG -O2"
        PROFILE=
        ;;
    *xlc*)
        CONFIG_UNIVERSAL_AIX=$CONFIG_UNIVERSAL_AIX_XLC
        LD="$CC"
        CONFIGURE_LDFLAGS="-qmkshrobj -bnoentry -bE:.objs/symbols.exp"
        LINK_STATIC="-bstatic"
        LINK_DYNAMIC="-bshared"
        MPD_PTHREAD="-qthreaded -D_THREAD_SAFE"
        MPD_WARN="-qlanglvl=stdc99"
        MPD_OPT="-DNDEBUG -O2 -qalias=ansi -qmaxmem=-1"
        PROFILE=
        ;;
    *suncc*)
        MPD_OPT="-DNDEBUG -O2"
        PROFILE=
        ;;
    *ccomp*)
        MPD_CONFIG="-DCONFIG_32 -DANSI -DLEGACY_COMPILER"
        MPD_OPT="-fstruct-passing -fstruct-assign -DNDEBUG"
        LD="gcc"
        LDFLAGS="-m32"
        PROFILE=
        ;;
    *)
        PROFILE=
        ;;
esac

# Auto-detect machine dependent settings:
EXPORTSYMS=
DETECTED_MACHINE=
if test $ac_cv_sizeof_size_t -eq 8; then
    EXPORTSYMS="symbols64.exp"
    if test $have_gcc_asm_for_x64 = yes; then
        DETECTED_MACHINE="x64"
    elif test $ac_cv_type___uint128_t = yes; then
        DETECTED_MACHINE="uint128"
    else
        DETECTED_MACHINE="ansi64"
    fi
else
    EXPORTSYMS="symbols32.exp"
    # Macros for detecting uint64_t and int64_t are unreliable:
    case $CC in
        *ccomp*)
            DETECTED_MACHINE="ansi-legacy"
            ;;
        *)
            DETECTED_MACHINE="ansi32"
            ;;
    esac
    if test $have_gcc_asm_for_x87 = yes; then
        case $CC in
            *gcc*|*clang*) # icc >= 11.0 works as well
                case $ac_sys_system in
                    darwin*|Darwin*)
                    ;;
                *)
                    DETECTED_MACHINE="ppro"
                    ;;
                esac
            ;;
        esac
    fi
fi
AC_SUBST(EXPORTSYMS)

if test -z "$MACHINE"; then
    MACHINE="$DETECTED_MACHINE"
fi

# Set configuration variables:
MPD_ABI=
MPD_PREC=9
MPD_DPREC=18
case "$MACHINE" in
    x64)
        MPD_HEADER_CONFIG=$CONFIG_64
        MPD_ABI=$M64
        MPD_CONFIG="-DCONFIG_64 -DASM"
        CONFIGURE_LDFLAGS="$CONFIGURE_LDFLAGS $M64"
        CONFIGURE_LDXXFLAGS="$CONFIGURE_LDXXFLAGS $M64"
        MPD_PREC=19
        MPD_DPREC=38
        ;;
    uint128)
        MPD_HEADER_CONFIG=$CONFIG_64
        MPD_ABI=$M64
        MPD_CONFIG="-DCONFIG_64 -DANSI -DHAVE_UINT128_T"
        CONFIGURE_LDFLAGS="$CONFIGURE_LDFLAGS $M64"
        CONFIGURE_LDXXFLAGS="$CONFIGURE_LDXXFLAGS $M64"
        MPD_PREC=19
        MPD_DPREC=38
        ;;
    ansi64)
        MPD_HEADER_CONFIG=$CONFIG_64
        MPD_ABI=$M64
        MPD_CONFIG="-DCONFIG_64 -DANSI"
        CONFIGURE_LDFLAGS="$CONFIGURE_LDFLAGS $M64"
        CONFIGURE_LDXXFLAGS="$CONFIGURE_LDXXFLAGS $M64"
        MPD_PREC=19
        MPD_DPREC=38
        ;;
    ppro)
        MPD_HEADER_CONFIG=$CONFIG_32
        MPD_ABI=$M32
        MPD_CONFIG="-DCONFIG_32 -DPPRO -DASM"
        CONFIGURE_LDFLAGS="$CONFIGURE_LDFLAGS $M32"
        CONFIGURE_LDXXFLAGS="$CONFIGURE_LDXXFLAGS $M32"
        # Some versions of gcc miscompile inline asm:
        # http://gcc.gnu.org/bugzilla/show_bug.cgi?id=46491
        # http://gcc.gnu.org/ml/gcc/2010-11/msg00366.html
        case $CC in
            *gcc*)
                AC_MSG_CHECKING(for gcc ipa-pure-const bug)
                saved_cflags="$CFLAGS"
                saved_ldflags="$LDFLAGS"
                CFLAGS="-O2"
                LDFLAGS=
                AC_RUN_IFELSE([AC_LANG_SOURCE([[
                __attribute__((noinline)) int
                foo(int *p) {
                  int r;
                  asm ( "movl \$6, (%1)\n\t"
                        "xorl %0, %0\n\t"
                        : "=r" (r) : "r" (p) : "memory"
                  );
                  return r;
                }
                int main() {
                  int p = 8;
                  if ((foo(&p) ? : p) != 6)
                    return 1;
                  return 0;
                }
                ]])],
                [have_ipa_pure_const_bug=no],
                [have_ipa_pure_const_bug=yes],
                [have_ipa_pure_const_bug=undefined])
                CFLAGS="$saved_cflags"
                LDFLAGS="$saved_ldflags"
                AC_MSG_RESULT($have_ipa_pure_const_bug)
                if test "$have_ipa_pure_const_bug" = yes; then
                    MPD_CONFIG="$MPD_CONFIG -fno-ipa-pure-const"
                    AC_DEFINE(HAVE_IPA_PURE_CONST_BUG, 1,
                [Define if gcc has the ipa-pure-const bug.])
                fi
            ;;
        esac
        ;;
    ansi32)
        MPD_HEADER_CONFIG=$CONFIG_32
        MPD_ABI=$M32
        MPD_CONFIG="-DCONFIG_32 -DANSI"
        CONFIGURE_LDFLAGS="$CONFIGURE_LDFLAGS $M32"
        CONFIGURE_LDXXFLAGS="$CONFIGURE_LDXXFLAGS $M32"
        ;;
    ansi-legacy)
        MPD_HEADER_CONFIG=$CONFIG_32_LEGACY
        MPD_ABI=$M32
        MPD_CONFIG="-DCONFIG_32 -DANSI -DLEGACY_COMPILER"
        CONFIGURE_LDFLAGS="$CONFIGURE_LDFLAGS $M32"
        CONFIGURE_LDXXFLAGS="$CONFIGURE_LDXXFLAGS $M32"
        ;;
    universal)
        MPD_HEADER_CONFIG=$CONFIG_UNIVERSAL
        MPD_CONFIG="-DUNIVERSAL"
        ;;
    *)
        echo "configure: error: cannot detect MACHINE"
        exit 1
        ;;
esac

# AIX: fix AR for the 64-bit build:
case $ac_sys_system in
AIX)
    MPD_OPT="-D_THREAD_SAFE $MPD_OPT"
    case "$MACHINE" in
    uint128|ansi64)
        if test x"$AR" = x"ar"; then
            AR="ar -X64"
        fi
        if test x"$RANLIB" = x"ranlib"; then
            RANLIB="ranlib -X64"
        fi
        ;;
    ansi32)
        :
        ;;
    universal)
        MPD_HEADER_CONFIG=$CONFIG_UNIVERSAL_AIX
        ;;
    *)
        echo "configure: error: invalid MACHINE variable for AIX: $MACHINE"
        exit 1
        ;;
    esac
    ;;
sun*|Sun*|NetBSD)
    MPD_OPT="-D_REENTRANT $MPD_OPT"
    ;;
esac

# Generate help strings:
AC_ARG_VAR(LDXX, [C++ linker (default is $CXX)])
AC_ARG_VAR(LDXXFLAGS, [C++ linker flags])

# Substitute variables and generate output:
if test -z "$LD"; then
    LD="$CC"
fi
if test -z "$LDXX"; then
    LDXX="$CXX"
fi
AC_SUBST(LD)
AC_SUBST(LDXX)
AC_SUBST(AR)
AC_SUBST(RANLIB)
AC_SUBST(MPD_HEADER)
AC_SUBST(MPD_PTHREAD)
AC_SUBST(MPD_WARN)
AC_SUBST(MPD_CONFIG)
AC_SUBST(MPD_HEADER_CONFIG)
AC_SUBST(MPD_OPT)
AC_SUBST(MPD_GNU99)

AC_SUBST(MPD_PGEN)
AC_SUBST(MPD_PUSE)
AC_SUBST(MPD_PREC)
AC_SUBST(MPD_DPREC)

if test -z "$INITIAL_CFLAGS"; then
    CONFIGURE_LIBMPDEC_CFLAGS="$MPD_WARN $MPD_CONFIG $MPD_OPT $MPD_ABI"
    CONFIGURE_CFLAGS="$MPD_WARN $MPD_OPT $MPD_ABI"
else
    CONFIGURE_LIBMPDEC_CFLAGS="$MPD_WARN $MPD_CONFIG $MPD_OPT $MPD_ABI $INITIAL_CFLAGS"
    CONFIGURE_CFLAGS="$MPD_WARN $MPD_OPT $MPD_ABI $INITIAL_CFLAGS"
fi

if test "$have_glibc_memmove_bug" = yes; then
    CONFIGURE_LIBMPDEC_CFLAGS="$CONFIGURE_LIBMPDEC_CFLAGS -U_FORTIFY_SOURCE"
    CONFIGURE_CFLAGS="$CONFIGURE_CFLAGS -U_FORTIFY_SOURCE"
fi

if test -z "$INITIAL_CXXFLAGS"; then
    CONFIGURE_CXXFLAGS="$MPD_WARNXX -DNDEBUG -O3 $MPD_ABI"
else
    CONFIGURE_CXXFLAGS="$MPD_WARNXX -DNDEBUG -O3 $MPD_ABI $INITIAL_CXXFLAGS"
fi

if test -n "$INITIAL_LDFLAGS"; then
    CONFIGURE_LDFLAGS="$CONFIGURE_LDFLAGS $INITIAL_LDFLAGS"
fi

if test -n "$INITIAL_LDXXFLAGS"; then
    CONFIGURE_LDXXFLAGS="$CONFIGURE_LDXXFLAGS $INITIAL_LDXXFLAGS"
fi

AC_SUBST(ENABLE_SHARED)
AC_SUBST(ENABLE_CXX)
AC_SUBST(PROFILE)

AC_SUBST(CONFIGURE_LIBMPDEC_CFLAGS)
AC_SUBST(CONFIGURE_CFLAGS)
AC_SUBST(CONFIGURE_LDFLAGS)

AC_SUBST(CONFIGURE_CXXFLAGS)
AC_SUBST(CONFIGURE_LDXXFLAGS)

AC_OUTPUT

GLIBC_MEMMOVE_BUG_WARN="
***************************** WARNING *********************************

Detected glibc _FORTIFY_SOURCE/memmove bug. See:

    http://sourceware.org/ml/libc-alpha/2010-12/msg00009.html

Enabling -U_FORTIFY_SOURCE workaround. If -D_FORTIFY_SOURCE is also
present in the command line, make sure that the order of the two
options is:

   ... -D_FORTIFY_SOURCE=2 ... -U_FORTIFY_SOURCE ...

A better solution is to upgrade glibc or to report the bug to your
OS vendor.

***************************** WARNING *********************************
"
if test "$have_glibc_memmove_bug" = yes; then
    echo "$GLIBC_MEMMOVE_BUG_WARN"
fi

