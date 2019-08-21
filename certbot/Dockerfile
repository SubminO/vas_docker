FROM python:3

MAINTAINER Yuriy Shikin <shikin@submin.ru>

RUN apt update \
    && apt install -y --no-install-recommends certbot

RUN pip install --upgrade pip \
    && pip install certbot-regru

COPY ./renew_cert.sh /root/
