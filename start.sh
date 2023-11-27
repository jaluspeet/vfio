#!/bin/bash
# Helpful to read output when debugging

# Stop display manager
systemctl stop display-manager.service

# Unbind VTconsoles
# echo 0 > /sys/class/vtconsole/vtcon0/bind
# echo 0 > /sys/class/vtconsole/vtcon1/bind

# Unbind EFI-Framebuffer
# echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Avoid a Race condition by waiting 2 seconds.
# sleep 2

# Unbind the GPU from display driver
virsh nodedev-detach pci_0000_26_00_0
virsh nodedev-detach pci_0000_26_00_1
virsh nodedev-detach pci_0000_26_00_2
virsh nodedev-detach pci_0000_26_00_3

# Load VFIO Kernel Module  
modprobe vfio
modprobe vfio_iommu_type1
modprobe vfio-pci  
