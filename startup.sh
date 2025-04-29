#!/bin/bash -ex

file='etc/krb5.conf'
sed -i 's/\<ENV_KERBEROS_REALM\>/'$KERBEROS_REALM'/g' $file
sed -i 's/\<ENV_DOMAIN\>/'$DOMAIN'/g' $file
sed -i 's/\<ENV_DOMAIN_CONTROLLER\>/'$DOMAIN_CONTROLLER'/g' $file

file='etc/sssd/sssd.conf'
sed -i 's/\<ENV_KERBEROS_REALM\>/'$KERBEROS_REALM'/g' $file
sed -i 's/\<ENV_DOMAIN\>/'$DOMAIN'/g' $file

service dbus start
service nmbd start
service sssd start
service smbd start

# Keep alive after starting service(s).
sleep infinity

