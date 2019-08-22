#!/usr/bin/env bash

CREDENTIALS="/root/regru.ini"

echo "certbot_regru:dns_username='$REGRUDNS_USER'" >> $CREDENTIALS
echo "certbot_regru:dns_password='$REGRUDNS_PASS'" >> $CREDENTIALS

chmod 600 $CREDENTIALS

certbot certonly -n --agree-tos --email $REGRUDNS_EMAIL -a certbot-regru:dns -d $REGRUDNS_DOMAIN \
    --certbot-regru:dns-credentials $CREDENTIALS --certbot-regru:dns-propagation-seconds $REGRUDNS_IDLE

cp  --recursive /etc/letsencrypt/* /root/certs/
