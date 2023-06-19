#!ipxe

#
# Ubuntu Installer
#

ifopen net{{ INTERFACE_ID }}
set net{{ INTERFACE_ID }}/ip {{ PUBLIC_IP }}
set net{{ INTERFACE_ID }}/netmask 255.255.255.0
set net{{ INTERFACE_ID }}/gateway {{ PUBLIC_GW }}
set net{{ INTERFACE_ID }}/dns 8.8.8.8

set seed_url https://raw.githubusercontent.com/anthonyra/vm-installer/main/ubuntu/jammy/templates/
set vmlinuz_url https://github.com/anthonyra/vm-installer/releases/download/22.04.2/vmlinuz
set initrd_url https://github.com/anthonyra/vm-installer/releases/download/22.04.2/initrd
set iso_url https://releases.ubuntu.com/jammy/ubuntu-22.04.2-live-server-amd64.iso

kernel ${vmlinuz_url} autoinstall url=${iso_url} ds=nocloud-net;s=${seed_url}
initrd ${initrd_url}
boot
