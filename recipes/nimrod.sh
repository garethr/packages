#!/bin/bash
VERSION="0.6.1"

cd /tmp
rm -fr nimrod
git clone git://github.com/sbtourist/nimrod.git
cd nimrod
lein deps
lein uberjar

cp nimrod-${VERSION}-SNAPSHOT-standalone.jar nimrod-standalone.jar

fpm -s dir -t deb -n nimrod -v $VERSION --prefix /opt/nimrod  \
  -p /home/vagrant/debs/nimrod-VERSION_ARCH.deb \
  nimrod-standalone.jar
