#!/bin/sh
## sleep 1000000
/usr/sbin/haproxy -f /etc/service/haproxy/haproxy.cfg &
{privoxy_instances}&
{tor_instances}
