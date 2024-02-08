# The mpdecimal source code

How to update the mpdecimal source code in this branch:

1. Dowload the new sources in tar.gz format from the
   [mpdecimal download page](https://www.bytereef.org/mpdecimal/download.html).

2. Validate the SHA256 checksum of the downloaded file.

3. Unpack the source code and commit the changes:

   ```console
   # Example with mpdecimal version 4.0.0
   $ git commit -am "Add mpdecimal 4.0.0 sources"
   ```

5. Tag the new commit:

   ```
   $ git tag -sam "mpdecimal 4.0.0" mpdecimal-4.0.0
   ```

6. Push changes, including tags, upstream.
