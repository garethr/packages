#!/bin/bash
# Build a repository from the debs in debs/.

set -e
export DEBIAN_FRONTEND=noninteractive

DISTRIBUTIONS="current"
COMPONENTS="main"
ARCHITECTURES="amd64 i386"
OWNER="Gareth Rushgrove"
GPGUSER="Gareth Rushgrove <gareth@morethanseven.net>"

rm -rf ../repo/*
mkdir -p ../repo/pool
cp ../debs/*.deb ../repo/pool/
cd ../repo

for dist in $DISTRIBUTIONS; do
  for comp in $COMPONENTS; do
    for arch in $ARCHITECTURES; do
      path=dists/$dist/$comp/binary-$arch
      mkdir -p $path
      cat >$path/Release <<END
Archive: $OWNER
Component: $comp
Origin: $OWNER
Label: $OWNER
Architecture: $arch
END
      dpkg-scanpackages -a $arch pool /dev/null > $path/Packages
      gzip -9c < $path/Packages > $path/Packages.gz
    done
  done
  cat > Release <<END
Origin: $OWNER
Label: $OWNER
Suite: $dist
Codename: $dist
Architectures: $ARCHITECTURES
Components: $COMPONENTS
Description: $OWNER
END
  apt-ftparchive release dists/$dist >> Release
  gpg -abs \
    --no-tty --local-user "${GPGUSER}" \
    --passphrase "${PASSPHRASE}" \
    --output dists/$dist/Release.gpg \
    Release
  mv Release dists/$dist/
done
