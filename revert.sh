#!/bin/bash

# vfio
modprobe -r vfio-pci
modprobe -r vfio_iommu_type1
modprobe -r vfio

# Rebind GPU to nvidia driver
virsh nodedev-reattach pci_0000_26_00_0
virsh nodedev-reattach pci_0000_26_00_1
virsh nodedev-reattach pci_0000_26_00_2
virsh nodedev-reattach pci_0000_26_00_3

# rebind VT consoles
# echo 1 > /sys/class/vtconsole/vtcon0/bind
# echo 1 > /sys/class/vtconsole/vtcon0/bind

# nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# reload nvidia modules
# modprobe nvidia_drm 
# modprobe nvidia_modeset
# modprobe drm_kms_helper 
# modprobe nvidia
# modprobe drm 
# modprobe nvidia_uvm

# echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind
nvidia-xconfig --query-gpu-info > /dev/null 2>&1

# restart display manager
systemctl start display-manager.service
