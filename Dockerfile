FROM openjdk:8u111-jre-alpine

MAINTAINER Dieter Wimberger "dieter@wimpi.net"

EXPOSE 10389

RUN apk add --no-cache openssl
RUN mkdir /ldap
WORKDIR /ldap
# Originally from https://github.com/kwart/ldap-server/releases/download/2017-09-04/ldap-server.jar
COPY ldap-server.jar .
COPY users.ldif /ldap/users.ldif

CMD ["java","-jar","ldap-server.jar", "users.ldif"]

# NOTE(Luke): the above image is based on the original image below

#FROM alpine:3.6
#
#MAINTAINER Josef (kwart) Cacek <josef.cacek@gmail.com>
#
#RUN echo "Installing APK packages" \
#    && apk add --update bash openjdk8 openssl \
#    && echo "Retrieving ldap-server.war" \
#    && wget -O /ldap-server.jar https://github.com/kwart/ldap-server/releases/download/2017-09-04/ldap-server.jar \
#    && echo "Cleaning APK cache" \
#    && rm -rf /var/cache/apk/*
#
#EXPOSE 10389 10636
#
#CMD ["java", "-jar", "/ldap-server.jar", "-sp", "10636"]
