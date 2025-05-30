#!/bin/bash -ex

service cron start
service nmbd start
service smbd start
service sssd start

# sssd needs the following:
touch /etc/sssd/sssd.conf
chown root:root /etc/sssd/sssd.conf
chmod 600 /etc/sssd/sssd.conf

# Keep alive after starting service(s).
sleep infinity

