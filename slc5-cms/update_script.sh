yum -y install make
yum -y groupinstall 'Development Tools'

export INSTALL_DIR=${PWD}/git-test-inst
export GETTEXT_VERSION=gettext-0.20.1
export CURL_VERSION=curl-7.65.0
export OPENSSL_VERSION=openssl-1.1.1g
export M4_VERSION=m4-1.4.18
export AUTOCONF_VERSION=autoconf-2.69
export GIT_VERSION=git-2.21.0
export PERL_VERSION=perl-5.30.2
export LD_LIBRARY_PATH=${INSTALL_DIR}/lib:${LD_LIBRARY_PATH}
export PATH=${INSTALL_DIR}/bin:${PATH}
cd ${INSTALL_DIR}

tar xzf ${GETTEXT_VERSION}.tar.gz
cd ${GETTEXT_VERSION}
./configure --prefix=${INSTALL_DIR}
make
make install
cd ..

tar -xzf ${PERL_VERSION}.tar.gz
cd ${PERL_VERSION}
./Configure -des
make
make install
cd ..

tar xzf ${OPENSSL_VERSION}.tar.gz
cd ${OPENSSL_VERSION}
CFLAGS=-fPIC ./config --prefix=${INSTALL_DIR} shared zlib
make
make install
cd ..

tar xzf ${CURL_VERSION}.tar.gz
cd ${CURL_VERSION}
./configure --with-ssl=${INSTALL_DIR} --prefix=${INSTALL_DIR}
make
make install
#ldd ${INSTALL_DIR}/lib/libcurl.so.4.5.0 
cd ..

tar xzf ${M4_VERSION}.tar.gz
cd ${M4_VERSION}
./configure --prefix=${INSTALL_DIR}
make -j16
make install

cd ..

tar xzf ${AUTOCONF_VERSION}.tar.gz
cd ${AUTOCONF_VERSION}
./configure --prefix=${INSTALL_DIR}
make -j16
make install
cd ..

tar xzf ${GIT_VERSION}.tar.gz 
cd ${GIT_VERSION}
make configure
./configure --prefix=${INSTALL_DIR} --with-openssl=${INSTALL_DIR} --with-curl=${INSTALL_DIR}
make -j16
make install -i
#ldd ${INSTALL_DIR}/libexec/git-core/git-remote-https