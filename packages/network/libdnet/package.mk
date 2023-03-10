# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libdnet"
PKG_VERSION="1.16.3"
PKG_SHA256="83171a9f6e96d7a5047d6537fce4c376bdf6d867f8d49cf6ba434a0f3f7b45c1"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/ofalk/libdnet"
	#origin: https://github.com/dugsong/libdnet
PKG_URL="https://github.com/ofalk/libdnet/archive/refs/tags/libdnet-1.16.3.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="A simplified, portable interface to several low-level networking routines"
PKG_TOOLCHAIN="autotools"
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_TARGET="ac_cv_func_strlcat=no \
                           ac_cv_func_strlcpy=no \
                           --enable-static \
                           --disable-shared \
			   --without-check \
                           --disable-python"

pre_configure_target() {
  export CFLAGS+=" -I$PKG_BUILD/include"
}

post_makeinstall_target() {
  cp $SYSROOT_PREFIX/usr/bin/dnet-config \
     $TOOLCHAIN/bin/dnet-config
}
