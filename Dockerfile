FROM ubuntu
MAINTAINER Bill C Riemers https://github.com/docbill/

ARG URL="https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu"

RUN apt-get update -y && apt-get install -y supervisor python  $(curl -w "%{url_effective}\n" -I -L -s -S $URL -o /dev/null) && apt-get clean all && rm -rf /tmp/*

ADD ./supervisord.sh /root/supervisord.sh
ADD ./supervisord.conf /etc/supervisord.conf
# ADD ./Dockerfile /Dockerfile

RUN chmod ugo+rx /root/supervisord.sh

VOLUME ["/config"]

EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp

WORKDIR /config/

CMD ["/root/supervisord.sh", "-c", "/etc/supervisord.conf", "-n"]

