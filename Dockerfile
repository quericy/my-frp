FROM busybox:stable
MAINTAINER quericy <quericy@live.com>

ARG FRP_VERSION=0.44.0


WORKDIR /tmp
RUN set -x \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz -O frp.tar.gz \
    && tar -zxf frp.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64 /var/frp \
    && mkdir -p /var/frp/conf \

COPY conf/frps.ini /var/frp/conf/frps.ini
COPY conf/frpc.ini /var/frp/conf/frpc.ini

VOLUME /var/frp/conf

WORKDIR /var/frp
CMD nohup sh -c '/var/frp/frps -c /var/frp/conf/frps.ini && /var/frp/frpc -c /var/frp/conf/frpc.ini'
