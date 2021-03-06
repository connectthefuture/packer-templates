#!/bin/sh

if [ ! $PACKER_BUILDER_TYPE = vmware-iso -a ! $PACKER_BUILDER_TYPE = vmware-vmx ]; then
    exit 0
fi

if [ -f /etc/redhat-release ]; then
    yum -y install perl fuse-libs
fi

# Install the VMWare Tools from a Linux ISO.
mkdir -p /mnt/vmware
mount -o loop /tmp/linux.iso /mnt/vmware
tar xzf /mnt/vmware/VMwareTools-*.tar.gz -C /tmp
umount /mnt/vmware
rmdir /mnt/vmware
rm -f /tmp/linux.iso

/tmp/vmware-tools-distrib/vmware-install.pl -d
rm -fr /tmp/vmware-tools-distrib

# VMware tools doesn't install on newer kernels, it exits recommending open-vm-tools be installed
if [ ! -f /usr/sbin/vmtoolsd ]; then
    if [ -f /etc/redhat-release ]; then
        yum install -y -q open-vm-tools
    else
        apt-get install -y -q open-vm-tools
    fi
fi
