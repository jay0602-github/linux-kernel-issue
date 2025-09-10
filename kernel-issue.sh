#!/bin/bash

current_kernel=$(uname -r)
echo "Current kernel: $current_kernel"

# Install latest kernel and required packages
echo "Updating system and installing latest kernel..."
dnf clean all -y
dnf install -y grub2-efi-x64 grub2-efi-x64-modules shim-x64
dnf upgrade -y kernel kernel-core kernel-modules

# Prepare GRUB environment
mkdir -p /boot/grub2/
grub2-editenv /boot/grub2/grubenv create

# Install/Update GRUB for UEFI
grub2-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB --recheck --force

# Generate GRUB configuration
grub2-mkconfig -o /boot/grub2/grub.cfg

# Set latest kernel as default
grub2-set-default 0
grub2-editenv list

echo "Kernel upgrade and GRUB update done. Please reboot the system."
