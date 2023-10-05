cpython-source-deps
===================

Source for packages that the CPython build process depends on.

It is currently expected that this will only be useful on Windows,
and in any case you should never need to clone this repository
unless you are updating its contents.

.. contents::

Updating Source Dependencies
----------------------------

The procedure for updating the different source dependencies are similar.  Below
is an example for updating SQLite::


1. Fork and clone this repository.

2. Checkout a new branch off the ``sqlite`` branch. Assuming this repo is set
   as your ``upstream``::

      git checkout -b <branch-name>-sqlite upstream/sqlite

3. Download SQLite source from `sqlite.org <https://www.sqlite.org>`_.

4. Unzip it to the branch checked out in step 2.

5. Commit and push the changes.

6. Create the PR, with ``sqlite`` as the base branch.

Once the PR has been merged, tag the commit as
``sqlite-<full version to be used in CPython's PCbuild/get_externals.bat>``.

For updating each project to be updated, follow the above instructions with
appropriate substitutions.  For ``sqlite``, ``bzip2``, ``xz``, and ``zlib``,
that's it!

For ``openssl``, ``tcl``/``tk``, and ``libffi``, builds of each should also be
checked into `cpython-bin-deps <https://github.com/python/cpython-bin-deps/>`_
for use in the CPython Windows build.  Each one has a ``prepare_<name>.bat``
script in the ``cpython`` ``PCbuild`` directory that will take care of building
the project.  Note, though, that builds checked into ``cpython-bin-deps`` need
to be signed by the release signing key, so it is generally up to a member of
the release management team to create those builds.


Download links
--------------

- ``sqlite``: https://www.sqlite.org/download.html
- ``bzip2``: https://www.sourceware.org/bzip2/downloads.html
- ``xz``: https://tukaani.org/xz/
- ``zlib``: https://zlib.net/
- ``tcl``/``tk``: https://tcl.tk/software/tcltk/download.html
- ``openssl``: https://www.openssl.org/source/
- ``libffi`` : https://github.com/libffi/libffi

Tagging the commit
------------------

Using the ``sqlite`` branch as an example::

   git checkout -b sqlite-tag upstream/sqlite
   git tag sqlite-3.21.0.0  # replace 3.21.0.0 with the correct version.
   git push --tags upstream

