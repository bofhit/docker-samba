#!/bin/bash -ex

service cron start
service nmbd start
service smbd start

if grep "^$SHARE_USER:" /etc/passwd; then
    echo "$SHARE_USER already exists."
else
    echo "Adding user $SHARE_USER..."
    useradd -m $SHARE_USER
    echo "$SHARE_USER:$SHARE_USER_PASSWD" | chpasswd
fi

# Add Samba user.
echo -e "$SHARE_USER_PASSWD\n$SHARE_USER_PASSWD" | \
    smbpasswd -a -s $SHARE_USER

sed -i "s/^\s*write list = .*/    write list = $SHARE_USER/" /etc/samba/smb.conf
sed -i "s/^\s*valid users = .*/    valid users = $SHARE_USER/" /etc/samba/smb.conf

# Keep alive after starting service(s).
sleep infinity

