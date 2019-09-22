FROM python:3.7-alpine

MAINTAINER Dmitriy Tihomirov <pp31622@yandex.ru>

MAINTAINER Yuriy Shikin <shikin@submin.ru>

COPY ./requirements.txt ./requirements.txt

RUN apk add --no-cache postgresql-libs \
    && apk add --no-cache --virtual .build-deps gcc \
    musl-dev postgresql-dev build-base python3-dev \
    jpeg-dev zlib-dev g++ gcc libxslt-dev \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r ./requirements.txt \
    && pip install gunicorn \
    && rm -f ./requirements.txt \
    && apk --purge del .build-deps

WORKDIR /opt/vas/www
