# The SQLite amalgamation source code

How to update the SQLite source code in this branch:

1. Download [the SQLite amalgamation](https://sqlite.org/amalgamation.html)
   from [the SQLite download page](https://sqlite.org/download.html)
   for the SQLite version you are upgrading to.

2. Validate the hash of the downloaded file with the hash on the download page.

3. Check out the `sqlite` branch of this repo:

   ```console
   $ git switch sqlite
   $ git pull
   ```

4. Unpack the amalgamation source code and commit the changes.

   ```console
   # Example with SQLite 3.41.2
   $ git commit -a -m "Add SQLite 3.41.2 sources"
   ```

5. Tag the new commit.

   ```console
   # The fourth number is unused, but kept for compatibility with the build scripts
   $ git tag -sam "SQLite 3.41.2" sqlite-3.41.2.0
   ```

6. Push changes (including tags) upstream.
