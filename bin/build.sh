#!/bin/bash
# Build a repository from the debs in debs/.

set -e
export DEBIAN_FRONTEND=noninteractive

DISTRIBUTIONS="lucid precise"
COMPONENTS="main"
ARCHITECTURES="amd64 i386"
OWNER="Gareth Rushgrove"
GPGUSER="Gareth Rushgrove <gareth@morethanseven.net>"

# start at a known location
cd $HOME

# remove the existing repository
rm -rf repo/*
mkdir -p repo/pool

# copy our pre-built packages into place
cp debs/*.deb repo/pool/
cd repo

# build up the repo structure for the specified distributions and
# architectures
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
      dpkg-scanpackages -m -a $arch pool /dev/null > $path/Packages
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
  # Sign the repo using the specified GPG key
  gpg -abs \
    --no-tty --local-user "${GPGUSER}" \
    --passphrase "${PASSPHRASE}" \
    --output dists/$dist/Release.gpg \
    Release
  mv Release dists/$dist/
done

# copy the public key into the correct place
cp ../*.gpg .
