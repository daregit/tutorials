Here's quick instruction describing Arch Linux installation and run docker services.

Please check: https://wiki.archlinux.org/title/installation_guide for more detailed guide.

Using pacstrap to install the base system, Linux kernel, firmware, and essential packages like vim, network manager, and docker 

    pacstrap /mnt base linux linux-firmware vim networkmanager grub ntp docker docker-compose

Enter newly installed system

    arch-chroot /mnt

Set root password

    passwd root

Setting vim as the default editor for the system.

    echo "export EDITOR=vim" >/etc/profile.d/00-editor.sh

Configure bootloader

    mkdir -p /boot/grub
    grub-mkconfig -o /boot/grub-cfg
    grub-install /dev/sda

Enable base services

    systemctl enable ntp
    systemctl enable docker
    systemctl enable NetworkManager

Adding a new user 'workuser' with a home directory.
Setting the password for 'workuser'.
Adding 'workuser' to the 'docker' and 'wheel' groups for Docker

    useradd -m workuser
    passwd workuser
    usermod -aG docker,wheel workuser
