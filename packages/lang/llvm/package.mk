# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="llvm"
PKG_VERSION="13.0.1"
PKG_SHA256="ec6b80d82c384acad2dc192903a6cf2cdbaffb889b84bfb98da9d71e630fc834"
PKG_ARCH="x86_64"
PKG_LICENSE="GPL"
PKG_SITE="http://llvm.org/"
PKG_URL="https://github.com/llvm/llvm-project/releases/download/llvmorg-13.0.1/llvm-13.0.1.src.tar.xz"
PKG_DEPENDS_HOST="toolchain"
PKG_DEPENDS_TARGET="toolchain llvm:host zlib"
PKG_LONGDESC="Low-Level Virtual Machine (LLVM) is a compiler infrastructure."
                       
  #because of "CMake Error at CMakeLists.txt:736 (message):
  #The target `"AMDGPU"' is experimental and must be passed via
  #LLVM_EXPERIMENTAL_TARGETS_TO_BUILD." , the following is changed.

		       #-DLLVM_TARGETS_TO_BUILD=\"AMDGPU\" \
		       #-DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=\"AMDGPU\" \
#disable AMDGPU


PKG_CMAKE_OPTS_COMMON="-DLLVM_INCLUDE_TOOLS=ON \
                       -DLLVM_BUILD_TOOLS=OFF \
                       -DLLVM_BUILD_UTILS=OFF \
                       -DLLVM_BUILD_EXAMPLES=OFF \
                       -DLLVM_INCLUDE_EXAMPLES=OFF \
                       -DLLVM_BUILD_TESTS=OFF \
                       -DLLVM_INCLUDE_TESTS=OFF \
                       -DLLVM_INCLUDE_GO_TESTS=OFF \
                       -DLLVM_BUILD_DOCS=OFF \
                       -DLLVM_INCLUDE_DOCS=OFF \
                       -DLLVM_ENABLE_DOXYGEN=OFF \
                       -DLLVM_ENABLE_SPHINX=OFF \
                       -DLLVM_ENABLE_TERMINFO=OFF \
                       -DLLVM_ENABLE_ASSERTIONS=OFF \
                       -DLLVM_ENABLE_WERROR=OFF \
                       -DLLVM_ENABLE_ZLIB=ON \
                       -DLLVM_BUILD_LLVM_DYLIB=ON \
                       -DLLVM_LINK_LLVM_DYLIB=ON \
                       -DLLVM_OPTIMIZED_TABLEGEN=ON \
                       -DLLVM_APPEND_VC_REV=OFF \
                       -DLLVM_ENABLE_RTTI=ON"

PKG_CMAKE_OPTS_HOST="$PKG_CMAKE_OPTS_COMMON \
                     -DCMAKE_INSTALL_RPATH=$TOOLCHAIN/lib"


#removed for a test
                         #-DCMAKE_C_FLAGS='$CFLAGS' \
                         #-DCMAKE_CXX_FLAGS='$CXXFLAGS' \
                         #-DLLVM_TARGET_ARCH=\"$TARGET_ARCH\" \

pre_configure_target() {
  PKG_CMAKE_OPTS_TARGET="$PKG_CMAKE_OPTS_COMMON \
                         -DCMAKE_BUILD_TYPE=MinSizeRel \
                         -DLLVM_TABLEGEN=$TOOLCHAIN/bin/llvm-tblgen"
}

make_host() {
  ninja $NINJA_OPTS llvm-config llvm-tblgen
}

makeinstall_host() {
  cp -a bin/llvm-config $SYSROOT_PREFIX/usr/bin/llvm-config-host
  cp -a bin/llvm-tblgen $TOOLCHAIN/bin
}

post_makeinstall_target() {
  rm -rf $INSTALL/usr/bin
  rm -rf $INSTALL/usr/lib/LLVMHello.so
  rm -rf $INSTALL/usr/lib/libLTO.so
  rm -rf $INSTALL/usr/share
}
