FROM python:3-alpine

MAINTAINER Yuriy Shikin <shikin@submin.ru>

WORKDIR /opt/beholder

COPY ./requirements.txt ./requirements.txt

RUN apk add --no-cache postgresql-libs \
    && apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev \
    && pip install --upgrade pip \
    && pip install --no-cache-dir -r ./requirements.txt \
    && rm -f ./requirements.txt \
    && apk --purge del .build-deps
