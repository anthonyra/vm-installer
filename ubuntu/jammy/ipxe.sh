#!ipxe

#
# Ubuntu Installer
#

set net{{ INTERFACE_ID }}/ip {{ PUBLIC_IP }}
set net{{ INTERFACE_ID }}/netmask 255.255.255.0
set net{{ INTERFACE_ID }}/gateway {{ PUBLIC_GW }}
set net{{ INTERFACE_ID }}/dns 8.8.8.8
ifopen net{{ INTERFACE_ID }}

set seed_url http://raw.githubusercontent.com/anthonyra/vm-installer/main/ubuntu/jammy/templates/
set vmlinuz_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/vmlinuz
set initrd_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/initrd
set iso_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/ubuntu-22.04.2-live-server-amd64.iso

kernel ${vmlinuz_url}
initrd ${initrd_url}
imgargs vmlinuz initrd=initrd boot=casper ip={{ PUBLIC_IP }}/24 url=${iso_url} autoinstall ds=nocloud-net;s=${seed_url}
boot
