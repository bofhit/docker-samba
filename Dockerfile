FROM ubuntu:24.04

RUN apt update && \
    apt upgrade -y && \
    apt install -y sssd-ad sssd-tools realmd adcli samba \
    # Remove after testing.
    dnsutils iputils-ping

COPY startup.sh /usr/bin
COPY sssd.conf /etc/sssd
COPY krb5.conf /etc
COPY krb5.keytab /etc

# A bit odd, but apparently necessary for sssd to run.
RUN chmod 600 /etc/sssd/sssd.conf && \
    chown root:root /etc/sssd/sssd.conf

ENTRYPOINT ["/usr/bin/startup.sh"]

# # Install samba
# RUN apk --no-cache --no-progress upgrade && \
#     apk --no-cache add bash samba shadow tini tzdata && \
#     #apk --no-cache --no-progress add bash samba shadow tini tzdata && \
#     addgroup -S smb && \
#     adduser -S -D -H -h /tmp -s /sbin/nologin -G smb -g 'Samba User' smbuser &&\
#     file="/etc/samba/smb.conf" && \
#     sed -i 's|^;* *\(log file = \).*|   \1/dev/stdout|' $file && \
#     sed -i 's|^;* *\(load printers = \).*|   \1no|' $file && \
#     sed -i 's|^;* *\(printcap name = \).*|   \1/dev/null|' $file && \
#     sed -i 's|^;* *\(printing = \).*|   \1bsd|' $file && \
#     sed -i 's|^;* *\(unix password sync = \).*|   \1no|' $file && \
#     sed -i 's|^;* *\(preserve case = \).*|   \1yes|' $file && \
#     sed -i 's|^;* *\(short preserve case = \).*|   \1yes|' $file && \
#     sed -i 's|^;* *\(default case = \).*|   \1lower|' $file && \
#     sed -i '/Share Definitions/,$d' $file && \
#     echo '   pam password change = yes' >>$file && \
#     echo '   map to guest = bad user' >>$file && \
#     echo '   usershare allow guests = yes' >>$file && \
#     echo '   create mask = 0664' >>$file && \
#     echo '   force create mode = 0664' >>$file && \
#     echo '   directory mask = 0775' >>$file && \
#     echo '   force directory mode = 0775' >>$file && \
#     echo '   force user = smbuser' >>$file && \
#     echo '   force group = smb' >>$file && \
#     echo '   follow symlinks = yes' >>$file && \
#     echo '   load printers = no' >>$file && \
#     echo '   printing = bsd' >>$file && \
#     echo '   printcap name = /dev/null' >>$file && \
#     echo '   disable spoolss = yes' >>$file && \
#     echo '   strict locking = no' >>$file && \
#     echo '   aio read size = 0' >>$file && \
#     echo '   aio write size = 0' >>$file && \
#     echo '   vfs objects = catia fruit recycle streams_xattr' >>$file && \
#     echo '   recycle:keeptree = yes' >>$file && \
#     echo '   recycle:maxsize = 0' >>$file && \
#     echo '   recycle:repository = .deleted' >>$file && \
#     echo '   recycle:versions = yes' >>$file && \
#     echo '' >> $file && \
#     echo '   # Security' >>$file && \
#     echo '   client ipc max protocol = SMB3' >>$file && \
#     echo '   client ipc min protocol = SMB2_10' >>$file && \
#     echo '   client max protocol = SMB3' >>$file && \
#     echo '   client min protocol = SMB2_10' >>$file && \
#     echo '   server max protocol = SMB3' >>$file && \
#     echo '   server min protocol = SMB2_10' >>$file && \
#     echo '' >>$file && \
#     echo '   # Time Machine' >>$file && \
#     echo '   fruit:delete_empty_adfiles = yes' >>$file && \
#     echo '   fruit:time machine = yes' >>$file && \
#     echo '   fruit:veto_appledouble = no' >>$file && \
#     echo '   fruit:wipe_intentionally_left_blank_rfork = yes' >>$file && \
#     echo '' >>$file && \
#     rm -rf /tmp/*
# 
# COPY samba.sh /usr/bin/
# 
# EXPOSE 137/udp 138/udp 139 445
# 
# HEALTHCHECK --interval=60s --timeout=15s \
#             CMD smbclient -L \\localhost -U % -m SMB3
# 
# #ENTRYPOINT ["/sbin/tini", "bash", "/usr/bin/samba.sh"]
# ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
# 
