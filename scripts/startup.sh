#!/bin/bash -ex

service cron start
service nmbd start
service smbd start

useradd -m $SHARE_USER
echo "$SHARE_USER:$SHARE_USER_PASSWD" | chpasswd

# Add Samba user.
echo -e "$SHARE_USER_PASSWD\n$SHARE_USER_PASSWD" | \
    smbpasswd -a -s $SHARE_USER

# Keep alive after starting service(s).
sleep infinity

