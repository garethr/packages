#!/bin/bash

cd /tmp
rm -fr lumberjack
git clone git://github.com/jordansissel/lumberjack.git
cd lumberjack
make deb

cp *.deb /home/vagrant/debs
