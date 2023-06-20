#!ipxe

#
# Ubuntu Installer
#
ifopen net{{ INTERFACE_ID }}
set net{{ INTERFACE_ID }}/ip {{ PUBLIC_IP }}
set net{{ INTERFACE_ID }}/netmask 255.255.255.0
set net{{ INTERFACE_ID }}/gateway {{ PUBLIC_GW }}
set net{{ INTERFACE_ID }}/dns 8.8.8.8

set seed_url http://raw.githubusercontent.com/anthonyra/vm-installer/main/templates/
set vmlinuz_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/vmlinuz
set initrd_url http://github.com/anthonyra/vm-installer/releases/download/22.04.2/initrd
set iso_url http://releases.ubuntu.com/22.04.2/ubuntu-22.04.2-live-server-amd64.iso

kernel ${vmlinuz_url}
initrd ${initrd_url}

show dns
set dns 8.8.8.8
show dns

imgargs vmlinuz \
    initrd=initrd \
    boot=casper \
    maybe-ubiquity \
    autoinstall \
    url=${iso_url} \
    net.ifnames=0 \
    biosdevname=0 \
    ipv6.disable=1 \
    ip={{ PUBLIC_IP }}::{{ PUBLIC_GW }}:255.255.255.0::enp1s0f0:off \
    ds=nocloud-net;s=${seed_url}
boot
