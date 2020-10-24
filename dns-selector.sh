#!/bin/sh

CONF_DIR="/opt/dnsmasq"

if [ $# -eq 0 ];then
    /usr/sbin/dnsmasq -k -q --log-facility=-
else
    /usr/sbin/dnsmasq -k -q --log-facility=- -r "$CONF_DIR"/"$1"-resolver
fi