@echo off

if exist c:\cygwin\bin\sh.exe goto :CONFIGURE_HEADERS

echo ERROR cygwin-x86 is required to run this script
echo Tested with cygwin-x86 from https://www.cygwin.com/install.html
echo Select http://mirrors.kernel.org as the download site
echo Include the following cygwin packages: make, autoconf, automake, libtool
echo.
echo Based on https://github.com/libffi/libffi/blob/master/.appveyor.yml
exit /b 127

:CONFIGURE_HEADERS

set LIBFFI_SOURCE=%~dp0

set OLDPWD=%LIBFFI_SOURCE%
pushd %LIBFFI_SOURCE%

set GET_MSVCC=c:\cygwin\bin\sh.exe -lc "cd $OLDPWD; export MSVCC=`/usr/bin/find $PWD -name msvcc.sh`; echo ${MSVCC};"
FOR /F "usebackq delims==" %%i IN (`%GET_MSVCC%`) do @set MSVCC=%%i

echo LIBFFI_SOURCE: %LIBFFI_SOURCE% 
echo MSVCC=%MSVCC%

c:\cygwin\bin\sh -lc "(cd $OLDPWD; ./autogen.sh;)"

call :BuildOne x86 i686-pc-cygwin
call :BuildOne x64 x86_64-w64-cygwin

popd
exit /b 0
REM all done


REM this subroutine is called once for each architecture
:BuildOne

setlocal

REM Initialize variables
set VCVARS_PLATFORM=%1
set BUILD=%2
set HOST=%2
set ML=

if "%VCVARS_PLATFORM%" EQU "" echo ERROR bad VCVARS_PLATFORM&&exit /b 123
if /I "%VCVARS_PLATFORM%" EQU "x64" (set ML=-m64)

REM clean header output directory
if exist %LIBFFI_SOURCE%\include\%VCVARS_PLATFORM% (rd %LIBFFI_SOURCE%\include\%VCVARS_PLATFORM% /s/q)

REM get VS build environment
call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" %VCVARS_PLATFORM%

REM just configure the build to generate fficonfig.h and ffi.h
REM c:\cygwin\bin\sh -lc "(cd $OLDPWD; ./autogen.sh;)"
REM c:\cygwin\bin\sh -lc "(cd $OLDPWD; export MSVCC=`/usr/bin/find $PWD -name msvcc.sh`; echo \"MSVCC=${MSVCC}\"; ./configure CC=''\"$MSVCC $ML\"' CXX='\"$MSVCC $ML\"'' LD='link' CPP='cl -nologo -EP' CXXCPP='cl -nologo -EP' CPPFLAGS='-DFFI_BUILDING' NM='dumpbin -symbols' STRIP=':' --build=$BUILD --host=$HOST;)"
REM if /I "%VCVARS_PLATFORM%" EQU "amd64" (
REM     c:\cygwin\bin\sh -lc "(cd $OLDPWD; ./configure CC='%MSVCC% %ML%' CXX='%MSVCC% %ML%' LD='link' CPP='cl -nologo -EP' CXXCPP='cl -nologo -EP' CPPFLAGS='-DFFI_BUILDING_DLL' NM='dumpbin -symbols' STRIP=':' --build=$BUILD --host=$HOST;)"
REM ) else (
REM     c:\cygwin\bin\sh -lc "(cd $OLDPWD; ./configure CC='/cygdrive/e/py/src_ffi/msvcc.sh' CXX='/cygdrive/e/py/src_ffi/msvcc.sh $ML' LD='link' CPP='cl -nologo -EP' CXXCPP='cl -nologo -EP' CPPFLAGS='-DFFI_BUILDING_DLL' NM='dumpbin -symbols' STRIP=':' --build=$BUILD --host=$HOST;)"
REM )
c:\cygwin\bin\sh -lc "(cd $OLDPWD; ./configure CC='%MSVCC% %ML%' CXX='%MSVCC% %ML%' LD='link' CPP='cl -nologo -EP' CXXCPP='cl -nologo -EP' CPPFLAGS='-DFFI_BUILDING_DLL' NM='dumpbin -symbols' STRIP=':' --build=$BUILD --host=$HOST;)"

REM There is no support for building .DLLs currently.
REM c:\cygwin\bin\sh -lc "(cd $OLDPWD; cp src/x86/ffitarget.h include; make; find .;)"

REM Running the libffi tests doesn't work when using msvc
REM msvcc.sh is missing support for -l and -L according to the note in appveyor.yml (see copy below)
REM c:\cygwin\bin\sh -lc "(cd $OLDPWD; cp `find . -name 'libffi-?.dll'` $HOST/testsuite/; make check; cat `find ./ -name libffi.log`)"

REM # FIXME: "make check" currently fails.  It just looks like msvcc needs
REM # to learn about -L and -l options.  If you add "make check; cat `find
REM # ./ -name libffi.log" to the end of that build command you'll see
REM # what I mean.

REM create header output directory and copy headers to check-in location
if not exist %LIBFFI_SOURCE%\include\%VCVARS_PLATFORM% (md %LIBFFI_SOURCE%\include\%VCVARS_PLATFORM%)
copy %LIBFFI_SOURCE%\%BUILD%\fficonfig.h  %LIBFFI_SOURCE%\include\%VCVARS_PLATFORM%
copy %LIBFFI_SOURCE%\%BUILD%\include\ffi.h  %LIBFFI_SOURCE%\include\%VCVARS_PLATFORM%

endlocal
exit /b

endlocal