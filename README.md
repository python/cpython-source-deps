# cpython-source-deps
Source for packages that the cpython build process depends on

## XZ Utils
Find updates for these at https://tukaani.org/xz/

We only include the bare minimum required files for building our _lzma module,
since the xz repository mixes licenses. liblzma is 0-BSD.

The windows\config.h header is created manually. To find out what the settings
ought to be, use the full xz sources to generate build projects using CMake,
and then inspect the project files.