This project contains a number of moving parts:

* A collection of fpm recipes for building debian packages
* Scripts for building a debian repository
* A small web server for serving the repository
* A Vagrant config to manage an ubuntu box to build the packages
* Utility scripts to instruct the Vagrant box to build recipes or the
  repository

The aim is to be able to either drop pre-build packages into the debs
directory or to write fpm scripts in the recipes folder and build a
debian repository. The resulting repository is shared back to the host.
The config.ru and Procfile should make serving that repo from Heroko 
or similar easy. 

This currently only really works with Ubuntu 12.04 but that should be
easy enough to fix given a bit of effort.
