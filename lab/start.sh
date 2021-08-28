#!/bin/env bash

set -euo pipefail

printf '52:54:2F:%02X:%02X:%02X' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]

networks=$(virsh net-list --name)
[[ ! "$networks" =~ "kidibox-nat" ]] && virsh net-create --file ./kidibox-nat.xml
[[ ! "$networks" =~ "kidibox-internal" ]] && virsh net-create --file ./kidibox-internal.xml

name=router
sudo qemu-img convert -f raw -O qcow2 ~/Downloads/chr-7.1rc1.img "/var/lib/libvirt/images/$name.qcow2"
virt-install \
  --name "$name" \
  --vcpus 2 \
  --ram 1024 \
  --os-type linux \
  --os-variant generic \
  --network model.type=virtio,mac.address=52:54:01:00:00:01,network=kidibox-nat \
  --network model.type=virtio,mac.address=52:54:01:00:00:02,network=kidibox-internal \
  --disk path="/var/lib/libvirt/images/$name.qcow2,bus=virtio" \
  --channel unix,target.type=virtio,name=org.qemu.guest_agent.0 \
  --autoconsole text \
  --rng /dev/urandom \
  --boot hd \

  # --channel unix,mode=bind,path="/var/lib/libvirt/qemu/$name.agent,target_type=virtio,name=org.qemu.guest_agent.0" \
# virt-install \
#   --name pve \
#   --cpu host-passthrough \
#   --vcpus 8 \
#   --ram 16386 \
#   --hvm \
#   --os-type linux \
#   --os-variant generic \
#   --console pty,target_type=virtio \
#   --network model.type=virtio,mac.address=52:54:00:00:0a:0a,bridge=qemu0 \
#   --disk path=/var/lib/libvirt/images/pve.qcow2,size=20,bus=virtio \
#   --cdrom /var/lib/libvirt/images/proxmox-ve_7.0-1.iso
