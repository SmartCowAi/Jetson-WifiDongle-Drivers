#! /usr/bin/env bash

# Script file to automaticall install the drivers for the tp-link TL-WN823N USB WiFi dongle on 
# the jetson devices.

# authorise sudo with a dummy command
sudo echo

#install necessary packages
sudo apt-get install git linux-headers-generic build-essential dkms


# create a temporary directory and clone the driver repository to it
cd $(mktemp -d)

git clone https://github.com/Mange/rtl8192eu-linux-driver
cd rtl8192eu-linux-driver

ls

# remove any prior installs
sudo dkms remove rtl8192eu/1.0 --all
make clean

# change the Makefile settings for installing on the Jetson
sed -i "s/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/" Makefile
sed -i "s/CONFIG_PLATFORM_ARM_AARCH64 = n/CONFIG_PLATFORM_ARM_AARCH64 = y/" Makefile

# install the driver package
sudo dkms add .
sudo dkms install rtl8192eu/1.0

# remove the repo
cd ..
rm -rf $(pwd)

# blacklist any other drivers for the same device
echo "blacklist wl" | sudo tee /etc/modprobe.d/blacklist-wl.conf
echo "blacklist rtl8xxxu" | sudo tee /etc/modprobe.d/blacklist-rtl8xxxu.conf

# prevent power managment on the device
echo "options 8192eu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/8192eu.conf
