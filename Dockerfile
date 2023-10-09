FROM alpine:3.18

RUN echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/testing'   >> /etc/apk/repositories && \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
	apk -U upgrade && \
    apk -v add tor@edge obfs4proxy@edge haproxy@edge python3@edge privoxy@edge curl && \
    chmod 700 /var/lib/tor && \
    rm -rf /var/cache/apk/* && \
    tor --version
	
COPY /files/haproxy.tpl /etc/service/haproxy/haproxy.tpl
COPY /files/torrc.tpl /etc/service/tor/torrc.tpl
COPY /files/privoxy.tpl /etc/service/privoxy/privoxy.tpl

COPY /files/shell.tpl /etc/service/tor/shell.tpl
COPY /files/torrc.python /etc/service/tor/generate.py
RUN chmod +x /etc/service/tor/generate.py

WORKDIR /etc/service/tor

CMD python3 /etc/service/tor/generate.py && chmod +x /usr/local/bin/goproxy.sh && /usr/local/bin/goproxy.sh