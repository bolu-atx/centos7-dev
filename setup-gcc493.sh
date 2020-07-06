#!/bin/bash
set -ex

CMAKE_URL="https://cmake.org/files/v3.14/cmake-3.14.5-Linux-x86_64.tar.gz"

########################################################################################################################
# CMake
########################################################################################################################

if hash cmake  2> /dev/null; then
    version=$(cmake --version)
    echo "Found CMake ${version}"
else
    wget --no-check-certificate --quiet -O - ${CMAKE_URL} | tar --strip-components=1 -xz -C /usr
fi

echo "CMake version"
cmake --version


########################################################################################################################
# gcc 493 
########################################################################################################################
yum install -y libmpc-devel mpfr-devel gmp-devel

cd /usr/src/
curl ftp://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-4.9.3/gcc-4.9.3.tar.bz2 -O
tar xvfj gcc-4.9.3.tar.bz2
cd gcc-4.9.3
./configure --disable-multilib --enable-languages=c,c++
make -j `grep processor /proc/cpuinfo | wc -l`
make install
make clean
rm -rf /usr/src/gcc-4.9*