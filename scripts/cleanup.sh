#!/bin/bash

# Remove files from shared folder.
find /srv/share -mtime +1 -type f ! -name README.txt -print0 | xargs -0 rm
