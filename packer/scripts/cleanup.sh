#!/bin/sh

apt-get -y remove build-essential
apt-get -y remove dkms

apt-get -y autoremove
apt-get -y clean
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?
