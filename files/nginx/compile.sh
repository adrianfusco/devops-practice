# Script made to compile Nginx and all required modules based on linux-x86_64

apt-get update -yqq
# We need GCC to build and compile
apt-get install -yqq wget build-essential

########
# zlib #
########
wget http://zlib.net/zlib-1.2.11.tar.gz
mkdir zlib
tar -xvf zlib-1.2.11.tar.gz
cd zlib*/
./configure
make && make install
cd ..
###########
# openssl #
###########
wget http://www.openssl.org/source/openssl-1.1.1g.tar.gz
tar -xvf openssl-1.1.1g.tar.gz
cd openssl*/
./Configure linux-x86_64 --prefix=/usr
make && make install
cd ..
########
# pcre #
########
wget https://ftp.pcre.org/pub/pcre/pcre-8.45.tar.bz2
tar -xjf pcre-8.45.tar.bz2
cd pcre*/ 
./configure
make && make install
cd ..
#########
# nginx #
#########
wget https://nginx.org/download/nginx-1.19.0.tar.gz
tar -xvf nginx-1.19.0.tar.gz
cd nginx*/
./configure \
--sbin-path=/usr/local/nginx/nginx \
--conf-path=/etc/nginx/nginx.conf \
--pid-path=/var/run/nginx.pid \
--with-zlib=../zlib-1.2.11 \
--with-http_ssl_module \
--with-stream \
--with-mail=dynamic \
--with-pcre=../pcre-8.45
make && make install

# Create .deb package structure:
mkdir nginx-personal-compilation_1.0-1
mkdir nginx-personal-compilation_1.0-1/usr
mkdir nginx-personal-compilation_1.0-1/usr/local
mkdir nginx-personal-compilation_1.0-1/usr/local/nginx
cp /usr/local/nginx/nginx nginx-personal-compilation_1.0-1/usr/local/nginx/
mkdir -p nginx-personal-compilation_1.0-1/etc/nginx
cp -Rf /etc/nginx/ nginx-personal-compilation_1.0-1/etc/nginx
mkdir nginx-personal-compilation_1.0-1/DEBIAN
touch nginx-personal-compilation_1.0-1/DEBIAN/control
cat <<EOT >> nginx-personal-compilation_1.0-1/DEBIAN/control
Package: nginx-personal-compilation
Version: 1.0-1
Section: base
Priority: optional
Maintainer: Adrian Fusco
Architecture: amd64 
Description: Nginx compiled

EOT
# Build .deb package
dpkg-deb --build nginx-personal-compilation_1.0-1
# Install
# dpkg -i --force-overwrite nginx-personal-compilation_1.0-1.deb
