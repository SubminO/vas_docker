#!/bin/bash

if [ ! -d /etc/ssl ]
then
    mkdir /etc/ssl
fi

cp -R /opt/certs/* /etc/ssl/
cp -R /opt/nginx/* /etc/

chmod -R 777 /var/log

/usr/sbin/nginx -g 'daemon off;'
