#!ipxe

#
# Ubuntu Installer
#

ifopen net{{ INTERFACE_ID }}
set net{{ INTERFACE_ID }}/ip {{ PUBLIC_IP }}
set net{{ INTERFACE_ID }}/netmask 255.255.255.0
set net{{ INTERFACE_ID }}/gateway {{ PUBLIC_GW }}
set net{{ INTERFACE_ID }}/dns 8.8.8.8

#
# The $seed_url is used by cloud-init's nocloud-net provider to find the user-data and meta-data files. 
# The trailing slash is important, the cloud-init process sticks 'meta-data' or 'user-data' right after, 
# without prepending a forward slash to the file name.
set seed_url https://raw.githubusercontent.com/anthonyra/vm-installer/main/ubuntu/jammy/templates/

set vmlinuz_url https://cloud-images.ubuntu.com/jammy/current/unpacked/jammy-server-cloudimg-amd64-vmlinuz-generic
set initrd_url https://cloud-images.ubuntu.com/jammy/current/unpacked/jammy-server-cloudimg-amd64-initrd-generic
set iso_url https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso

kernel ${vmlinuz_url} autoinstall url=${iso_url} ds=nocloud-net;s=${seed_url}
initrd ${initrd_url}
boot

# Notes on what ip= kernel boot parameter means
# https://www.kernel.org/doc/Documentation/filesystems/nfs/nfsroot.txt
# The purpose of ip= in this script is to configure the hostname of the initial ubuntu installer environment, so that doesn't use the default ubuntu-server hostname.
# If you leave the default ubuntu-server hostname, it can cause confusion at the DHCP level if you do many concurrent/parallel builds.