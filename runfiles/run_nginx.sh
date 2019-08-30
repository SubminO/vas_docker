#!/bin/bash

cp -R /opt/certs/* /etc/ssl/
cp -R /opt/nginx/* /etc/

chmod -R 777 /var/log

/usr/sbin/nginx -g 'daemon off;'
