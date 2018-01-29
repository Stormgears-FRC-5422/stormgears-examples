#!/bin/bash

PKG=stormgears-examples
PKGVER=2018.1.0
PKGREL=1

. /etc/os-release
dist=$ID$VERSION_ID
codename=$VERSION_CODENAME
[ -z "$codename" ] && codename=$(echo $VERSION | sed 's/.*(\(.*\)).*/\1/')

WD=$(dirname $0)
[ "$WD" == "." ] && WD=$PWD

rm -rf $WD/work
mkdir -p $WD/work/${PKG}-${PKGVER}
cp -r $WD/deb $WD/work/${PKG}-${PKGVER}/debian

cp -r data $WD/work/${PKG}-${PKGVER}/
cp -r steamworks-vision $WD/work/${PKG}-${PKGVER}/

cat > $WD/work/${PKG}-${PKGVER}/debian/changelog <<EOF
$PKG (${PKGVER}-${PKGREL}.$dist) $codename; urgency=medium

  * Automatically generated

 -- W. Mark Smith <wmsmith@gmail.com>  $(date -R)
EOF
tar -C work -czf work/${PKG}_${PKGVER}.orig.tar.gz ${PKG}-${PKGVER}

cat <<EOF
Source files are prepared. You have two options:
(1) Build deb package:
  cd $WD/work/${PKG}-${PKGVER} && dpkg-buildpackage -us -uc -b
(2) Prepare upload for PPA:
  cd $WD/work/${PKG}-${PKGVER} && dpkg-buildpackage -S
EOF

cd $WD

