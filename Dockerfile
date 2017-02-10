FROM nginx
MAINTAINER Reittiopas version: 0.1
ENV INSTALL_DIR="/opt/nginx"
RUN mkdir -p $INSTALL_DIR /opt/nginx/www /opt/nginx/cache /opt/nginx/geocache /opt/nginx/temp-cache /opt/nginx/cache/temp /var/cache/nginx/client_temp /var/cache/nginx/fastcgi_temp/ /var/cache/nginx/uwsgi_temp /var/cache/nginx/scgi_temp

ADD index.html /opt/nginx/www/
ADD nginx.conf /etc/nginx/nginx.conf
ADD common.conf /etc/nginx/common.conf
ADD legacy-redirects.conf /etc/nginx/legacy-redirects.conf

RUN rm /var/log/nginx/* && chmod -R a+rwX ${INSTALL_DIR} /etc/nginx/ /var/log/nginx/ /var/cache/nginx/ /var/run/
#USER 9999

#because we dont want to use disk on the containers for logs

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log


WORKDIR /etc/nginx
EXPOSE 8080

ADD run.sh /usr/local/bin/

CMD ["/usr/local/bin/run.sh"]
