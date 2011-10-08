#!/bin/bash
VERSION="0.4.12"

git clone git://github.com/joyent/node
cd node
git checkout v$VERSION

time (./configure --prefix=/usr && make && make install DESTDIR=installdir)

fpm -s dir -t deb -n nodejs -v $VERSION -C installdir \
  -p nodejs-VERSION_ARCH.deb \
  -d "libstdc++6 (>= 4.4.3)" \
  -d "libc6 (>= 2.6)" \
  -d "libssl0.9.8 (>= 0.9.8)" \
  -d "zlib1g (>= 1:1.2.2)" \
  usr/bin usr/lib usr/share/man usr/include
