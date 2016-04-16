FROM fedora
MAINTAINER Bill C Riemers https://github.com/docbill/

ENV URL='https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=redhat'

RUN dnf update -y && dnf install -y supervisor python  $(curl -w "%{url_effective}\n" -I -L -s -S $URL -o /dev/null) && dnf clean all && rm -rf /tmp/*

ADD ./supervisord.sh /root/supervisord.sh
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./Dockerfile /Dockerfile

RUN chmod ugo+rx /root/supervisord.sh

VOLUME ["/config"]

EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp

WORKDIR /config/

CMD ["/root/supervisord.sh", "-n"]

