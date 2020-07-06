#!/usr/bin/env bash
# ========================= BOOST ======================
PREFIX=/opt/boost
if [[ ! -e $PREFIX ]] ; then
    echo "======Creating destination directory at $PREFIX========"
    mkdir -p $PREFIX
fi

boost158_url="https://phoenixnap.dl.sourceforge.net/project/boost/boost/1.58.0/boost_1_58_0.tar.bz2"
boost167_url="https://dl.bintray.com/boostorg/release/1.67.0/source/boost_1_67_0.tar.bz2"

function download_boost() 
{
    url=$1
    boost_archive_name=`basename $url`
    if [ ! -z $1 ]; then
        wget $1
        if [ ! $? -eq 0 ]; then
            return 1
        fi
        tar xjf $boost_archive_name
        if [ $? -eq 0 ]; then
            boost_archive_dir=${boost_archive_name%.tar.bz2}
            return 0
        else
            return 1
        fi
    else
        echo "need valid url for boost download."
        return 1
    fi
}

function build_boost_158() 
{
    download_boost $boost158_url

    if [ $? -eq 0 ]; then
        cd $boost_archive_dir
        ./bootstrap.sh --prefix=$PREFIX
        ./b2 -j 2 cxxflags="-std=c++11" link=shared,static address-model=64 variant=release threading=multi --layout=system install
        cd ..
        rm -rf boost*
    else
        echo "Boost 1.58 downloadinng / extraction failed."
    fi
}

function build_boost_167() 
{

    echo "=======Compiling boost 1.67==========="
    download_boost $boost167_url
    if [ $? -eq 0 ] ; then
        cd $boost_archive_dir 
        ./bootstrap.sh --prefix=$PREFIX
        ./b2 -j 2 --prefix=$PREFIX cxxflags="-std=c++11 -fPIC" cflags=-fPIC link=shared,static address-model=64 variant=release threading=multi --layout=system --with-system --with-filesystem --with-thread --with-regex --with-serialization install
        cd ..
    else
        echo "Cannot download boost 1.67, check the url"
        exit 1
    fi

    echo "========Cleaning up======"

    rm -rf boost_1_*
}


read -p "Build boost 1.58 (y/n)?" choice
case "$choice" in 
    y|Y ) build_boost_158;;
n|N ) echo "skipping boost 158";;
* ) echo "invalid";;
      esac
      read -p "Build boost 1.67 (y/n)?" choice
      case "$choice" in 
          y|Y ) build_boost_167;;
      n|N ) echo "skipping boost 167";;
  * ) echo "invalid";;
      esac