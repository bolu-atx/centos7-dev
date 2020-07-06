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
yum install -y centos-release-scl-rh
yum install -y devtoolset-9-gcc devtoolset-9-gcc-c++ devtoolset-9-gdb