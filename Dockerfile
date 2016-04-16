FROM centos
MAINTAINER Bill C Riemers <docbill@gmail.com>
ENV URL='https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=redhat' URL2=' http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm'

RUN yum update -y && \
	yum install -y python python-setuptools $(curl -w "%{url_effective}\n" -I -L -s -S "$URL" -o /dev/null) "$URL2" && \
	easy_install supervisor && \
	yum clean all && rm -rf /tmp/*

ADD ./supervisord.sh /root/supervisord.sh
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./Dockerfile /Dockerfile

RUN chmod ugo+rx /root/supervisord.sh

VOLUME ["/config"]

EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp

WORKDIR /config/

CMD ["/root/supervisord.sh", "-c", "/etc/supervisord.conf", "-n"]

