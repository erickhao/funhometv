# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2019 EricHao (funhome.tv)

PKG_NAME="apache2"
PKG_VERSION="2.4.54"
PKG_SHA256="eb397feeefccaf254f8d45de3768d9d68e8e73851c49afd5b7176d1ecf80c340"
PKG_ARCH="any"
PKG_LICENSE="Apache LICENSE"
PKG_SITE="https://httpd.apache.org"
PKG_URL="http://mirrors.tuna.tsinghua.edu.cn/apache//httpd/httpd-$PKG_VERSION.tar.bz2"
# PKG_MAINTAINER="John Doe" # Full name or forum/GitHub nickname, if you want to be identified as the addon maintainer
PKG_DEPENDS_TARGET="toolchain zlib openssl apr apr-util expat pcre acmesh"
#PKG_SECTION="[location under packages, e.g. database]"
PKG_SECTION="web"
PKG_SHORTDESC="[the web server]"
PKG_LONGDESC="[The Number One HTTP Server On The Internet. The Apache HTTP Server Project is an effort to develop and maintain an open-source HTTP server for modern operating systems including UNIX and Windows. The goal of this project is to provide a secure, efficient and extensible server that provides HTTP services in sync with the current HTTP standards.  The Apache HTTP Server (\"httpd\") was launched in 1995 and it has been the most popular web server on the Internet since April 1996. It has celebrated its 20th birthday as a project in February 2015.]"
PKG_TOOLCHAIN="configure"

#PKG_BUILD_FLAGS="-gold"
#PKG_CMAKE_OPTS_TARGET="-DWITH_EXAMPLE_PATH=/storage/.example
#                      "


#$(get_build_dir
#H_APR_DIR=$(get_build_dir apr)/.armv7ve-libreelec-linux-gnueabi
H_APR_DIR=$(get_build_dir apr)/.$TARGET_NAME
#H_APU_DIR=$(get_build_dir apr-util)/.armv7ve-libreelec-linux-gnueabi
H_APU_DIR=$(get_build_dir apr-util)/.$TARGET_NAME
H_PCRE_DIR=$(get_build_dir pcre)/.$TARGET_NAME

#echo "H_PCRE_DIR is : $H_PCRE_DIR="

#
#remove for a test
#--enable-cache-disk \
#


#in order fix the report we haoyq @2023-1-12 "checking for -pcre2-config... no
#checking for -pcre-config... no
#configure: error: pcre(2)-config for libpcre not found.  "
	#



PCRE_CONFIG="$H_PCRE_DIR/pcre-config"
export PCRE_CONFIG

PKG_CONFIGURE_OPTS_TARGET=" ap_cv_void_ptr_lt_long=no \
 --enable-ssl \
 --enable-so \
 --enable-rewrite \
 --enable-proxy \
 --with-mpm=event \
 --enable-proxy-fcgi \
 --enable-headers \
 --enable-dir \
 --enable-mime \
 --enable-setenvif \
 --with-apr=$H_APR_DIR \
 --with-apr-util=$H_APU_DIR \
 --with-pcre=$H_PCRE_DIR \
 --enable-cache \
 --enable-socache-redis "
#PKG_MAKE_OPTS_TARGET=" -l$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib/libpcre.so "

pre_configure_target() {


# copy from samba's pre_configure_target
# in order to remove the duplicate of struct iovec
# the following line it removed because of x86 
#  if [ "$TARGET_ARCH" = "arm" ]; then
  #export CFLAGS+=" -DAPR_IOVEC_DEFINED  -lpthread -lpcre2  -L$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib "
  export CFLAGS+=" -DAPR_IOVEC_DEFINED  -lpthread  -L$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib "
#  fi


}


#pre_configure_target() {
#PKG_CONFIGURE_OPTS_TARGET="ac_cv_file__dev_zero=yes \
#			  ac_cv_func_setpgrp_void=yes \
#			  apr_cv_tcp_nodelay_with_cork=yes "



pre_make_target() {

echo "should configure OK!!!!!!!!!!!!! ready for make !!!!!!!!!!!!!!!!!!!!!!!"
#remove the following from Makefile
#test_char.h: gen_test_char
#	./gen_test_char > test_char.h
sed -i 's"test_char.h: gen_test_char""' server/Makefile
sed -i 's"./gen_test_char > test_char.h""' server/Makefile
#pc local gen-test-char
#from https://www.cnblogs.com/zhangsf/archive/2013/08/21/3272960.html
#/home/ubuntu/localAPM/apache2/httpd-2.4.41/server/gen_test_char > /xtr/ubuntu/LbrELEC/LibreELEC.tv/build.LibreELEC-RPi2.arm-9.0-devel/apache2-2.4.41/.armv7ve-libreelec-linux-gnueabi/server/test_char.h
cat > server/test_char.h <<EOF
/* this file is automatically generated by gen_test_char, do not edit */
#define T_ESCAPE_SHELL_CMD     (1)
#define T_ESCAPE_PATH_SEGMENT  (2)
#define T_OS_ESCAPE_PATH       (4)
#define T_HTTP_TOKEN_STOP      (8)
#define T_ESCAPE_LOGITEM       (16)
#define T_ESCAPE_FORENSIC      (32)
#define T_ESCAPE_URLENCODED    (64)
#define T_HTTP_CTRLS           (128)
#define T_VCHAR_OBSTEXT        (256)
#define T_URI_UNRESERVED     (0x200)

static const unsigned short test_char_table[256] = {
    0x0a8,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,
    0x0fe,0x07e,0x0ff,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,
    0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,
    0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,0x0fe,
    0x00e,0x140,0x15f,0x146,0x141,0x166,0x141,0x141,
    0x149,0x149,0x101,0x140,0x148,0x100,0x100,0x14a,
    0x100,0x100,0x100,0x100,0x100,0x100,0x100,0x100,
    0x100,0x100,0x168,0x14b,0x14f,0x148,0x14f,0x14f,
    0x148,0x100,0x100,0x100,0x100,0x100,0x100,0x100,
    0x100,0x100,0x100,0x100,0x100,0x100,0x100,0x100,
    0x100,0x100,0x100,0x100,0x100,0x100,0x100,0x100,
    0x100,0x100,0x100,0x14f,0x15f,0x14f,0x147,0x100,
    0x147,0x100,0x100,0x100,0x100,0x100,0x100,0x100,
    0x100,0x100,0x100,0x100,0x100,0x100,0x100,0x100,
    0x100,0x100,0x100,0x100,0x100,0x100,0x100,0x100,
    0x100,0x100,0x100,0x14f,0x167,0x14f,0x141,0x0fe,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,
    0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e,0x17e
};

#define TEST_CHAR(c, f) (test_char_table[(unsigned char)(c)] & (f))
EOF





}
post_makeinstall_target() {

#remove manual of apache2 20200304
rm -fr $INSTALL/usr/manual
rm -fr $SYSROOT_PREFIX/usr/manual

cp -P $PKG_REAL_BUILD/.libs/httpd $INSTALL/usr/bin/apache2
echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!apache2 is make installed :$INSTALL"

# in order to correct apxs's build path,and preserve the old one as .back and .orig
# in apxs '29th line , "my $installbuilddir = "/usr/build";"
# add the host apache2 install directory to it's path prefix , for php to build with apxs , and apxs get correct config_vars in host
cp -P $INSTALL/usr/bin/apxs $INSTALL/usr/bin/apxs.orig
  APACHE2_DIR=$(get_build_dir apache2)/.install_pkg
cp -P $APACHE2_DIR/usr/bin/apxs $APACHE2_DIR/usr/bin/apxs.orig
#echo $INSTALL>$APACHE2_DIR/usr/bin/h_apache_sed2
#echo "|">$APACHE2_DIR/usr/bin/h_apache_sed3
echo "s|build\";|build\";\$installbuilddir=\"$INSTALL\"+\$installbuilddir;|">$APACHE2_DIR/usr/bin/h_apache_sed
#echo "s|build;|$INSTALL|">$APACHE2_DIR/usr/bin/h_apache_sed
#cat 's|build";|$installbuilddir+=$INSTALL|'>$APACHE2_DIR/usr/bin/hapache-sed1 <EOF
#echo "$APACHE2_DIR/usr/bin/h_apache_sed1 $APACHE2_DIR/usr/bin/h_apache_sed2 $APACHE2_DIR/usr/bin/h_apache_sed3 have a check!!!!"
#cat $APACHE2_DIR/usr/bin/h_apache_sed1 '$installbuilddir+=' $APACHE2_DIR/usr/bin/h_apache_sed2 $APACHE2_DIR/usr/bin/h_apache_sed3 > $APACHE2_DIR/usr/bin/h_apache_sed
#sed -f $APACHE2_DIR/usr/bin/h_apache_sed -iback $APACHE2_DIR/usr/bin/apxs

#apache2.4.54 support cross compiling ? , it have destdir aware of directory in apxs. we don't change any more . haoyq @2023/1/12
#sed -iback "s|build\";|build\";\$installbuilddir=\"$INSTALL\".\$installbuilddir;|" $APACHE2_DIR/usr/bin/apxs


#sed -i 's|build";|$installbuilddir+=$INSTALL|' $INSTALL/usr/build/config_vars.mk



# corrent config_vars.mk the last several line of APU-CONFIG and APR-CONFIG
cp -P $INSTALL/usr/build/config_vars.mk $INSTALL/usr/build/config_vars.mk.orig

#echo  $INSTALL > $APACHE2_DIR/usr/build/h_configvarsmk_sed2
#echo "|" > $APACHE2_DIR/usr/build/h_configvarsmk_sed3
#echo "s|APR_CONFIG = |APR_CONFIG = " > $APACHE2_DIR/usr/build/h_configvarsmk_sed1
#cat $APACHE2_DIR/usr/build/h_configvarsmk_sed1 $APACHE2_DIR/usr/build/h_configvarsmk_sed2 $APACHE2_DIR/usr/build/h_configvarsmk_sed3> $APACHE2_DIR/usr/build/h_configvarsmk_sed
#sed -i "s|APR_CONFIG = |APR_CONFIG = $INSTALL/|" $APACHE2_DIR/usr/build/config_vars.mk
#$TOOLCHAIN/$TARGET_NAME/sysroot/usr/lib/

#apache2.4.54 maybe support cross compile, we stop fix apxs, and not stop fix config_vars.mk , we haoyq @ 2023/1/12"
#sed -iback "s|APR_CONFIG = |APR_CONFIG = $TOOLCHAIN/$TARGET_NAME/sysroot|" $APACHE2_DIR/usr/build/config_vars.mk

# APR OK , now APU
#echo "s|APU_CONFIG = |APU_CONFIG = " > $APACHE2_DIR/usr/build/h_configvarsmk_sed1
#cat $APACHE2_DIR/usr/build/h_configvarsmk_sed1 $APACHE2_DIR/usr/build/h_configvarsmk_sed2 $APACHE2_DIR/usr/build/h_configvarsmk_sed3> $APACHE2_DIR/usr/build/h_configvarsmk_sed

#like upper , 2.4.54 , we haoyq @ 2023/1/12
#sed -ibackr "s|APU_CONFIG = |APU_CONFIG = $TOOLCHAIN/$TARGET_NAME/sysroot|" $APACHE2_DIR/usr/build/config_vars.mk

ls -l $APACHE2_DIR/usr/build/config_vars.mk
##replace all the " usr/" with $SYSROOT_PREFIX/usr/ within config_vars.mk 
#like upper , 2.4.54 , we haoyq @ 2023/1/12
#sed -i.pfx "s# usr/# $SYSROOT_PREFIX/usr/#g" $APACHE2_DIR/usr/build/config_vars.mk
#ls -l $APACHE2_DIR/usr/build/config_vars.mk
#echo "#############################################################have a check config_vars.mk #####"

#copy the fixed config_vars.mk to sysroot
#backup first 
cp $SYSROOT_PREFIX/usr/build/config_vars.mk $SYSROOT_PREFIX/usr/build/config_vars.mk.orig
cp $APACHE2_DIR/usr/build/config_vars.mk $SYSROOT_PREFIX/usr/build

# and copy apxs to sysroot
cp $APACHE2_DIR/usr/bin/apxs $SYSROOT_PREFIX/usr/bin

mkdir -p $SYSROOT_PREFIX/usr/lib/systemd/system
cp -v $PKG_DIR/system.d/apache2.service $SYSROOT_PREFIX/usr/lib/systemd/system
mkdir -p $INSTALL/usr/lib/systemd/system
cp -v $PKG_DIR/system.d/apache2.service $INSTALL/usr/lib/systemd/system

#remove the mod_disk_cache.so #####need to fixit , because it should be fine to work
#sed -i.hfx "s|^LoadModule cache_disk_module lib/mod_cache_disk.so|#LoadModule cache_disk_module lib/mod_cache_disk.so|" $SYSROOT_PREFIX/etc/httpd.conf

#make directory for    SSLCertificateFile      /storage/.kodi/apache/etc/ssl/certs/ssl-cert-snakeoil.pem
#    SSLCertificateKeyFile /storage/.kodi/apache/etc/ssl/private/ssl-cert-snakeoil.key
# we cannot directly put files in /storage/.kodi/apache/etc/ssl/{cert|private} , so we just put /etc/apache/etc/ssl/{cert|private} , and copy it to there when system startup
# it is just a workground for self generated certificate . For applied certificate , should use /storage/.kodi/apache/etc/ssl/{cert|private} . It can be renewed.
mkdir -p $INSTALL/etc/apache/etc/ssl/certs
mkdir -p $INSTALL/etc/apache/etc/ssl/private
echo "cp -Pv $PKG_DIR/certs/fullchain.cer  $INSTALL/etc/apache/etc/ssl/certs/ssl-cert-snakeoil.pem"
cp -Pv $PKG_DIR/certs/fullchain.cer  $INSTALL/etc/apache/etc/ssl/certs/ssl-cert-snakeoil.pem
echo "cp -Pv $PKG_DIR/certs/b.funhome.tv.key  $INSTALL/etc/apache/etc/ssl/private/ssl-cert-snakeoil.key"
cp -Pv $PKG_DIR/certs/b.funhome.tv.key  $INSTALL/etc/apache/etc/ssl/private/ssl-cert-snakeoil.key
chmod 600 $INSTALL/etc/apache/etc/ssl/private/ssl-cert-snakeoil.key

# install make-tls-cert  of self generated certificate.
mkdir -p $INSTALL/usr/bin
cp -Pv $PKG_DIR/maketlscert/make-tls-cert $INSTALL/usr/bin/
cp -Pv $PKG_DIR/maketlscert/etc/ssl/ssleay.cnf $INSTALL/etc/apache/etc/ssl

# install gen-server-name
# should mkdir -p $INSTALL/usr/bin
cp -Pv $PKG_DIR/genservername/gen-server-name $INSTALL/usr/bin
 
# install acme-install
cp -Pv $PKG_DIR/acmeinstall/acmeinstall $INSTALL/usr/bin

#emit a installscript for system startup to copy or setup  SSLCertifateFile to /storage/.kodi/apache/etc/ssl/{certs|private}
cat >$INSTALL/usr/bin/apachecertcp.sh <<EOFCERT
#!/bin/bash
#and haoyq we should make dir /var/logs and /var/log/apache2
mkdir -p /var/logs
mkdir -p /var/log/apache2

#prepare a myservername.conf for httpd.conf to include , httpd.conf puted in php/conffiles, production in /etc directory.
#gen-server-name is missleading , get the hostname is indeed , for the apache2 server.  So , when hostname is changed, funhomenic should run it.
/usr/bin/gen-server-name

#if on reboot , a.k.a the certificate file is there , or maybe updated, we shouldn't overwrite it. 
#if the user changed the hostname , funhome.tv.settings should apply certificate and acme.sh should work for it , and after and only certificate applied , restart apache. When the file is not exist , the apache should not start , or even started , maybe danger for nextcloud.
if [ ! -s /storage/.kodi/apache/etc/ssl/certs/ssl-cert-snakeoil.pem ]; then

	/usr/bin/acmeinstall
	# make extract first to do and delay postreg , so apache2.service should as early as possible , to parally work.
	#depend on nextcloud package 
	#extract nextcloud archive for setup  , * to make the version ignored , just put it . 2022/12/3
	tar  xfj /usr/www/nextcloud/nextcloud-*.tar.bz2 -C /storage
	#add an autoconfig.php in nextcloud package , for user to input less and select mariadb , adjust data directory, and name an admin user nc.
	cp -P /usr/www/nextcloud/autoconfig.php /storage/nextcloud/config
	
	#make php.opcache directory for php.opcache-filecache
	chown -R daemon:daemon /storage/nextcloud
	#we haoyq should make nextchoud/config/config.php 's trusted network is "*"
	mkdir -p /storage/nextcloud/.opcache
	chown daemon:daemon /storage/nextcloud/.opcache
	mkdir -p /storage/nextclouddata
	chown daemon:daemon /storage/nextclouddata
	
	#for immich
	mkdir -p /storage/immichdata
	chown daemon:daemon /storage/immichdata
	
	# to enable funhome-settings debug . FIXME remember to remove it when production.
	touch /storage/.cache/debug.libreelec
	
	#make service of apache2 mariadb php-fpm zerotier-one transmission autostart in funhomesettings.

	#consider make it into a init script.because the apache2 certificate is needed to generated on settings start
	touch /storage/.cache/services/nextcloud.conf
	#touch /storage/.cache/services/zerotier.conf
	touch /storage/.cache/services/transmission.conf
        
        #the following is moved to acmeinstall , in order to install acme.sh early.
	#ready the certificate env for apache and acme.sh
	#mkdir -p /storage/.kodi/apache/etc/ssl/certs
	#mkdir -p /storage/.kodi/apache/etc/ssl/private
	#the reloadcmd.sh is needed by funhome.tv.setting , in acme.sh
	#cp -P /usr/www/acmesh/reloadcmd.sh /storage/.kodi/apache/reloadcmd.sh
	#chmod 755 /storage/.kodi/apache/reloadcmd.sh
	#cp -P /etc/apache/etc/ssl/ssleay.cnf /storage/.kodi/apache/etc/ssl

	# install acme.sh
	#tar xfz /usr/www/acmesh/3.0.5.tar.gz -C /storage
	#cd /storage/acme.sh-3.0.5
	#mkdir /storage/.acme.sh
	#HOME=/storage /storage/acme.sh-3.0.5/acme.sh --install
	#mkdir -p /storage/.acme.sh/dnsapi
	#cp -Pv /usr/www/acmesh/dns_funhometv.sh /storage/.acme.sh/dnsapi/
	### end of acmeinstall

	# factory reg 
	# 2022/12/12 we put factory reg to funhome.tv.settings to do , to avoid race condtions.
	# in order to avoid the temp name resolve problem , just delay several seconds. maybe not a good idea.
	# we haoyq removed the sleep 
	# factory reg should before funhome.tv.settings to get started to generate name and make user accept the name .
	# first generate machineid , then have a name.
	#sleep 20
	#if [ ! -s /storage/.config/factory.status ]; then     #maybe put it later , problem solved.
	#cat /etc/resolv.conf >> /storage/.cache/postreglog
	#date >> /storage/.cache/postreglog
	#python /usr/bin/postreg.py >> /storage/.cache/postreglog 2>&1 
	#fi 



	#here after postreg.py registed machine-id , a nic action should taken , to register the "hostname".funhome.tv with dns.
	#in order to make the certificate take effect , a dtx action should taken , to apply certificate from issuer . put in funhome.tv.settings , and it will call acme.sh
	# in acme.sh , after certificate is applied successful , it should triger the action of restart apache.

	#can also make it happen in funhome.tv.settings wizard of first run.
	#cp -P /etc/apache/etc/ssl/certs/ssl-cert-snakeoil.pem  /storage/.kodi/apache/etc/ssl/certs/ssl-cert-snakeoil.pem
	#cp -P /etc/apache/etc/ssl/private/ssl-cert-snakeoil.key  /storage/.kodi/apache/etc/ssl/private/ssl-cert-snakeoil.key
	# if there is no hostname , it's a problem for make-tls-cert . when name changed, it should regenerated. so we choose to make funhome.tv.settings to do the job  , and change the mode of the key
	#/usr/bin/make-tls-cert generate-default-snakeoil 
	#chmod 600 /storage/.kodi/apache/etc/ssl/private/ssl-cert-snakeoil.key


	gpg --import /flash/pubkey.4ck 
	#systemctl restart apache2
fi

EOFCERT

chmod 755 $INSTALL/usr/bin/apachecertcp.sh
#copy the postreg to /usr/bin
cp -Pv $PKG_DIR/factoryreg/postreg.py $INSTALL/usr/bin/postreg.py
#the reloadcmd.sh is installed by acme.sh

#cp -Pv $INSTALL/etc/ssl/private/ssl-cert-snakeoil.key  $INSTALL/storage/.kodi/apache/etc/ssl/private/ssl-cert-snakeoil.key

}

post_install(){

# enable the service
echo " enable apache2.service"
enable_service apache2.service

#add user
    echo "add_user daemon"
    add_group daemon 65532
    add_user daemon x 65532 65532 "apache2" "/" "/bin/sh"
}
