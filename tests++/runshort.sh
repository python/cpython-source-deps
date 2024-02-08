#!/bin/sh


PORTABLE_PWD=`pwd`

THREAD="--thread" # std::thread

SYSTEM=`uname -s`
case $SYSTEM in
    darwin*|Darwin*)
        # malloc() on OS X does not conform to the C standard.
        export MallocLogFile=/dev/null
        export MallocDebugReport=crash
        ;;
    AIX)
        # The thread stack size on AIX (96K) makes std::thread unusable
        # for runtest.cc, which needs around 300K.
        THREAD="--pthread"
        ;;
    *)
        ;;
esac


# Download or copy the official test cases (text files).
./gettests.sh "$1" || exit 1


printf "\n# ========================================================================\n"
printf "#                        libmpdec++: static library\n"
printf "# ========================================================================\n\n"

if [ x"$1" != x"--local" ]; then
    printf "Running official tests ...\n\n"

    ./runtest official.topTest $THREAD || { printf "\nFAIL\n\n\n"; exit 1; }
fi


printf "Running additional tests ...\n\n"

./runtest additional.topTest $THREAD || { printf "\nFAIL\n\n\n"; exit 1; }


printf "Running API tests (single thread) ... \n\n"

./apitest || { printf "\nFAIL\n\n\n"; exit 1; }


printf "Running API tests (threaded) ... \n\n"

./apitest --thread || { printf "\nFAIL\n\n\n"; exit 1; }


if [ ! -f ./runtest_shared ]; then
    exit 0
fi


printf "\n# ========================================================================\n"
printf "#                        libmpdec++: shared library\n"
printf "# ========================================================================\n\n"

LD_LIBRARY_PATH="$PORTABLE_PWD/../libmpdec:$PORTABLE_PWD/../libmpdec++"
LD_32_LIBRARY_PATH="$PORTABLE_PWD/../libmpdec:$PORTABLE_PWD/../libmpdec++"
export LD_LIBRARY_PATH
export LD_32_LIBRARY_PATH


if [ x"$1" != x"--local" ]; then
    printf "Running official tests ...\n\n"

    ./runtest_shared official.topTest $THREAD || { printf "\nFAIL\n\n\n"; exit 1; }
fi


printf "Running additional tests ...\n\n"

./runtest_shared additional.topTest $THREAD || { printf "\nFAIL\n\n\n"; exit 1; }


printf "Running API tests (single thread) ... \n\n"

./apitest_shared || { printf "\nFAIL\n\n\n"; exit 1; }


printf "Running API tests (threaded) ... \n\n"

./apitest_shared --thread || { printf "\nFAIL\n\n\n"; exit 1; }


