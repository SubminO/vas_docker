FROM python:3-alpine

MAINTAINER Yuriy Shikin <shikin@submin.ru>

WORKDIR /opt/translator

COPY ./requirements.txt ./requirements.txt

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r ./requirements.txt \
    && rm -f ./requirements.txt
