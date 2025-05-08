#!/bin/bash

# Remove files from shared folder.
echo $(date +%Y-%m-%dT%H:%M:%S)
find /srv/share -mtime +1 -type f ! -name README.txt -print0 | xargs -0 rm

