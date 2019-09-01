FROM nginx

MAINTAINER Yuriy Shikin <shikin@submin.ru>

RUN apt update \
    && apt install -y --no-install-recommends \
    tzdata \
    locales \
    libltdl7 \
    logrotate \
    vim \
    wget \
    tcpdump \
    telnet \
    dnsutils \
    && apt autoremove -y \
    && rm -r /var/cache/apt/archives/* \
    && rm -r /var/lib/apt/*

RUN locale-gen ru_RU.UTF-8

RUN ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && dpkg-reconfigure -f noninteractive tzdata
