cpython-source-deps
===================

Source for packages that the CPython build process depends on.

It is currently expected that this will only be useful on Windows,
and in any case you should never need to clone this repository
unless you are updating its contents.

.. contents::

Updating SQLite Source Dependencies
-----------------------------------

1. Fork and clone this repository.

2. Checkout a new branch off the `sqlite` branch. Assuming this repo is set
   as your `upstream`::

      git checkout -b <branch-name>-sqlite upstream/sqlite

3. Download sqlite source from `sqlite.org`.

4. Unzip it to the checked out branch on step 2.

5. Commit and push the changes.

6. Create the PR, with `sqlite` as the base branch.

Once the PR has been merged, tag the commit as `sqlite-<full version specified in CPython's PCbuild/get_externals.bat>`.

