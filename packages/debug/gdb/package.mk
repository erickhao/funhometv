# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="gdb"
PKG_VERSION="11.2"
PKG_SHA256="1497c36a71881b8671a9a84a0ee40faab788ca30d7ba19d8463c3cc787152e32"
PKG_LICENSE="GPL"
PKG_SITE="http://www.gnu.org/software/gdb/"
PKG_URL="https://ftp.gnu.org/gnu/gdb/gdb-11.2.tar.xz"
PKG_DEPENDS_TARGET="toolchain zlib ncurses expat gmp"
PKG_LONGDESC="GNU Project debugger, allows you to see what is going on inside another program while it executes."
# gdb could fail on runtime if build with LTO support

PKG_CONFIGURE_OPTS_TARGET="bash_cv_have_mbstate_t=set \
                           --disable-shared \
                           --enable-static \
                           --with-auto-load-safe-path=/ \
                           --disable-nls \
                           --disable-sim \
                           --without-x \
                           --disable-tui \
                           --disable-libada \
                           --without-lzma \
                           --disable-libquadmath \
                           --disable-libquadmath-support \
                           --enable-libada \
                           --enable-libssp \
                           --disable-werror"

pre_configure_target() {
  CC_FOR_BUILD="$HOST_CC"
  CFLAGS_FOR_BUILD="$HOST_CFLAGS"
}

makeinstall_target() {
  make DESTDIR=$INSTALL install
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/share/gdb/python
}
