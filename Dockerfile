FROM alpine:3.12

MAINTAINER Sourav Sarker <sourav.sub25@gmail.com>

RUN mkdir -p /opt/src
WORKDIR /opt/src

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8

RUN apk update -q
RUN apk add --update -q python3 python3-dev  py3-pip bash g++ curl wget tar yarn ca-certificates
RUN apk --no-cache add zip
RUN rm -f /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python

RUN apk add --update nodejs nodejs-npm -q

COPY requirements.txt /
RUN pip install --upgrade pip
RUN pip install -q --upgrade -r /requirements.txt

RUN apk --no-cache add  -q openjdk8 openjdk11
ENV JAVA_HOME_8="/usr/lib/jvm/java-1.8-openjdk"
ENV JAVA_HOME_11="/usr/lib/jvm/java-11-openjdk"

ENV JAVA_HOME=$JAVA_HOME_11
ENV PATH=$PATH:.:$JAVA_HOME/bin

RUN apk --no-cache add -q maven
