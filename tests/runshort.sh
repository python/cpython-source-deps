#!/bin/sh


PORTABLE_PWD=`pwd`

# malloc() on OS X does not conform to the C standard.
SYSTEM=`uname -s`
case $SYSTEM in
    darwin*|Darwin*)
        export MallocLogFile=/dev/null
        export MallocDebugReport=crash
        ;;
    *)
        ;;
esac


# Download the official test cases (text files).
./gettests.sh "$1" || exit 1


printf "\n# ========================================================================\n"
printf "#                         libmpdec: static library\n"
printf "# ========================================================================\n\n"

if [ x"$1" != x"--local" ]; then
    printf "Running official tests ...\n\n"

    ./runtest official.decTest || { printf "\nFAIL\n\n\n"; exit 1; }
fi


printf "Running additional tests ...\n\n"

./runtest additional.decTest || { printf "\nFAIL\n\n\n"; exit 1; }


if [ ! -f ./runtest_shared ]; then
    exit 0
fi


printf "\n# ========================================================================\n"
printf "#                         libmpdec: shared library\n"
printf "# ========================================================================\n\n"

LD_LIBRARY_PATH="$PORTABLE_PWD/../libmpdec"
LD_32_LIBRARY_PATH="$PORTABLE_PWD/../libmpdec"
export LD_LIBRARY_PATH
export LD_32_LIBRARY_PATH


if [ x"$1" != x"--local" ]; then
    printf "Running official tests ...\n\n"

    ./runtest_shared official.decTest || { printf "\nFAIL\n\n\n"; exit 1; }
fi


printf "Running additional tests ...\n\n"

./runtest_shared additional.decTest || { printf "\nFAIL\n\n\n"; exit 1; }


