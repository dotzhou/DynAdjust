#!/usr/bin/env bash

set -e

sudo apt-get -y update

sudo add-apt-repository multiverse
sudo apt-get -y update

sudo apt-get -y install p7zip
sudo apt-get -y install libboost-all-dev
sudo apt-get -y install libxerces-c-dev
sudo apt-get -y install cmake
sudo apt-get -y install make
sudo apt-get -y install g++
sudo apt-get -y install xsdcxx

# for development
sudo apt-get -y install git
sudo apt-get -y install xorg
sudo apt-get -y install vim-gnome
sudo apt-get -y install firefox
# PDF reader if not use browser
sudo apt-get -y install okular

# netcdf for GMT
sudo apt-get -y install libnetcdf-dev
sudo apt-get -y install netcdf-bin

# gdal for GMT
sudo apt-get -y install gdal-bin
sudo apt-get -y install gdal-data
sudo apt-get -y install libgdal-dev

# build and install GMT
mkdir -p .local/share
pushd .local/share
cp -f /tmp/scripts/install_gmt4.sh ./
cp -f /tmp/scripts/GMT4param.txt ./
sudo sh install_gmt4.sh GMT4param.txt
popd

# tools for GMT
sudo apt-get -y install epstool
sudo apt-get -y install gnuplot

# for MKL
pushd /tmp
wget https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo apt-key add GPG-PUB-KEY-INTEL-SW-PRODUCTS-2019.PUB
sudo sh -c 'echo deb https://apt.repos.intel.com/mkl all main > /etc/apt/sources.list.d/intel-mkl.list'
sudo apt-get -y update
sudo apt-get -y install intel-mkl-64bit-2018.1-038
popd

# build and install DynAdjust
sh -c 'git clone https://github.com/icsm-au/DynAdjust.git'
pushd DynAdjust/dynadjust
cp -f /tmp/scripts/make_dynadjust_gcc_ubuntu.sh ./
cp -f /tmp/scripts/CMakeLists.release.txt ./
cp -f /tmp/scripts/FindXercesC_ubuntu.cmake ./
cp -f /tmp/scripts/FindXSD_ubuntu.cmake ./
sudo sh make_dynadjust_gcc_ubuntu.sh release
popd

