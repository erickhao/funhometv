# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="libretro-mame2016"
PKG_VERSION="02987af9b81a9c3294af8fb9d5a34f9826a2cf4d"
PKG_SHA256="4bd7e13d94506f6f556ddc3615b230645d72114f377cb84297dfd284372a4c5b"
#PKG_SHA256="d09ce628901f8b19417f05a84aa7cb1bc2b567b05b0de2bb425451d62f897507"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/libretro/mame2016-libretro"
PKG_URL="https://github.com/libretro/mame2016-libretro/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux glibc alsa-lib"
PKG_LONGDESC="Late 2016 version of MAME (0.174) for libretro. Compatible with MAME 0.174 romsets."
PKG_TOOLCHAIN="make"

PKG_LIBNAME="mame2016_libretro.so"
PKG_LIBPATH="${PKG_LIBNAME}"
PKG_LIBVAR="MAME2016_LIB"

make_target() {
  if [ "${ARCH}" = "arm" ]; then
    PKG_NOASM="1"
  else
    PKG_NOASM="0"
  fi

  if [ "${ARCH}" = "x86_64" ]; then
    PKG_PTR64="1"
  else
    PKG_PTR64="0"
  fi

  make REGENIE=1 VERBOSE=1 NOWERROR=1 PYTHON_EXECUTABLE=python2 CONFIG=libretro \
       LIBRETRO_OS="unix" ARCH="" PROJECT="" LIBRETRO_CPU="${ARCH}" DISTRO="debian-stable" \
       CROSS_BUILD="1" OVERRIDE_CC="${CC}" OVERRIDE_CXX="${CXX}" \
       PTR64="${PKG_PTR64}" NOASM="${PKG_NOASM}" TARGET="mame" \
       SUBTARGET="arcade" PLATFORM="${ARCH}" RETRO=1 OSD="retro" GIT_VERSION=${PKG_VERSION:0:7}
}

post_make_target() {
  mv ${PKG_BUILD}/mamearcade2016_libretro.so ${PKG_BUILD}/mame2016_libretro.so
}

makeinstall_target() {
  mkdir -p ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}
  cp ${PKG_LIBPATH} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME}
  echo "set(${PKG_LIBVAR} ${SYSROOT_PREFIX}/usr/lib/${PKG_LIBNAME})" > ${SYSROOT_PREFIX}/usr/lib/cmake/${PKG_NAME}/${PKG_NAME}-config.cmake
}
