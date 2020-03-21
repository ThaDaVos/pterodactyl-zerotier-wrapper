ARG SOURCE

FROM ${SOURCE} as src

EXPOSE 9993/udp

USER root

RUN ([ -x "$(command -v apk)" ] && echo "OS supportes apk" && apk add --update libgcc libc6-compat libstdc++) || echo "OS does not support apk"
RUN ([ -x "$(command -v apt)" ] && echo "OS supportes apt") || echo "OS does not support apt"

RUN mkdir -p /var/lib/zerotier-one
COPY --from=spikhalskiy/zerotier-containerized:latest  /usr/sbin/zerotier-cli /usr/sbin/zerotier-cli
COPY --from=spikhalskiy/zerotier-containerized:latest  /usr/sbin/zerotier-idtool /usr/sbin/zerotier-idtool
COPY --from=spikhalskiy/zerotier-containerized:latest  /usr/sbin/zerotier-one /usr/sbin/zerotier-one
COPY zerotier-entrypoint.sh /zerotier-entrypoint.sh

COPY gosu /usr/local/bin/gosu 

ENTRYPOINT ["/zerotier-entrypoint.sh"]