FROM ubuntu:24.10

RUN apt update && \
    apt upgrade -y && \
    apt install -y samba \
        cron

EXPOSE 137/udp 138/udp 139 445

RUN mkdir /srv/share &&\
    chmod 777 /srv/share

COPY "smb.conf" "/etc/samba/smb.conf"
COPY "scripts/" "/scripts"

COPY "SHARE-README.txt" "/srv/share/README.txt"

RUN sed -i 's/SHELL=\/bin\/sh/SHELL=\/bin\/bash/' /etc/crontab
RUN echo "2 15 * * * root /scripts/cleanup.sh >> /var/log/cron.log 2>&1" >> /etc/crontab
RUN chmod 744 "/srv/share/README.txt"

ENTRYPOINT ["/scripts/startup.sh"]

