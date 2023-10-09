confdir /etc/privoxy
logdir /var/log/privoxy
logfile privoxy.{http_port}.log
listen-address  127.0.0.1:{http_port}
forward-socks5 / 127.0.0.1:{port} .