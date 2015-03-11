# VERSION 0.1
# AUTHOR:         John Wiebalk <john.wiebalk@me.com>
# DESCRIPTION:    Image with DokuWiki & Httpd
# TO_BUILD:       docker build -t wolfador/dokuwiki .
# TO_RUN:         docker run -d -p 80:80 --name wiki wolfador/dokuwiki


FROM centos:centos6
MAINTAINER John Wiebalk <john.wiebalk@me.com>

# Set the version you want of Twiki
ENV DOKUWIKI_VERSION 2014-09-29b
ENV DOKUWIKI_CSUM 605b14aad2f85f2f6a66ccb7c0a494e9

ENV LAST_REFRESHED 23. February 2015

# base system upgrade and system dependencies
RUN yum upgrade -y && \
    yum install -y \
      httpd php rsync wget tar rsyslog php-ldap mod_ssl && \
    yum clean all

# Download & deploy twiki
RUN wget -O /dokuwiki.tgz \
    "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-$DOKUWIKI_VERSION.tgz"
RUN if [ "$DOKUWIKI_CSUM" != "$(md5sum /dokuwiki.tgz | awk '{print($1)}')" ];\
  then echo "Wrong md5sum of downloaded file!"; exit 1; fi;
RUN tar -zxf dokuwiki.tgz
RUN mv "/dokuwiki-$DOKUWIKI_VERSION" /var/www/html/wiki

# Set up ownership
RUN chown -R apache:apache /var/www/html

# Cleanup
RUN rm dokuwiki.tgz

# Configure lighttpd
#ADD dokuwiki.conf /etc/lighttpd/conf-available/20-dokuwiki.conf
#RUN lighty-enable-mod dokuwiki fastcgi accesslog
#RUN mkdir /var/run/lighttpd && chown www-data.www-data /var/run/lighttpd

EXPOSE 80
#VOLUME ["/dokuwiki/data/","/dokuwiki/lib/plugins/","/dokuwiki/conf/","/dokuwiki/lib/tpl/","/var/log/"]

##ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
ENTRYPOINT ["bash","service rsyslog start"]
ENTRYPOINT ["apachectl", "-d", ".", "-f", "/etc/httpd/conf/httpd.conf", "-e", "info", "-DFOREGROUND"]
# add the start script
#ADD start.sh start.sh

# entrypoint is the start script
#ENTRYPOINT ["bash","start.sh"]

