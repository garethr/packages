#!/bin/bash

cd /tmp
rm -fr jmxtrans
git clone git://github.com/jmxtrans/jmxtrans.git
cd jmxtrans
ant debian
cp target/jmxtrans_*_all.deb /home/vagrant/debs
