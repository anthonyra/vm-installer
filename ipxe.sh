#!ipxe

#
# Ubuntu Installer
#

set net{{ INTERFACE_ID }}/ip {{ PUBLIC_IP }}
set net{{ INTERFACE_ID }}/netmask 255.255.255.0
set net{{ INTERFACE_ID }}/gateway {{ PUBLIC_GW }}
set net{{ INTERFACE_ID }}/dns 8.8.8.8
ifopen net{{ INTERFACE_ID }}

set seed_url http://raw.githubusercontent.com/anthonyra/vm-installer/main/templates/
set vmlinuz_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/vmlinuz
set initrd_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/initrd
set iso_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/ubuntu-22.04.2-live-server-amd64.iso

kernel ${vmlinuz_url} || read void
initrd ${initrd_url} || read void
imgargs vmlinuz initrd=initrd boot=casper maybe-ubiquity ip={{ PUBLIC_IP }}::{{ PUBLIC_GW }}:255.255.255.0::enp1s0f0:off url=${iso_url} autoinstall ds=nocloud-net;s=${seed_url} || read void
boot || read void
