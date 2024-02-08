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
./gettests.sh || exit 1


printf "\n# ========================================================================\n"
printf "#                         libmpdec: static library\n"
printf "# ========================================================================\n\n"

printf "Running official tests with allocation failures ...\n\n"

./runtest official.decTest --alloc || { printf "\nFAIL\n\n\n"; exit 1; }


printf "Running additional tests with allocation failures ...\n\n"

./runtest additional.decTest --alloc || { printf "\nFAIL\n\n\n"; exit 1; }


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


printf "Running official tests with allocation failures ...\n\n"

./runtest_shared official.decTest --alloc || { printf "\nFAIL\n\n\n"; exit 1; }


printf "Running additional tests with allocation failures ...\n\n"

./runtest_shared additional.decTest --alloc || { printf "\nFAIL\n\n\n"; exit 1; }


