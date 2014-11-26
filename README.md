configuration
=============

# archKDE-EFI

Note de développement et script

##  Linux Distro

Installation de la distribution [archlinux](https://www.archlinux.fr/)

## Installation et configuration

Cette installation enlève entierement Windows. La configuration s'installe sur un boot UEFI et une partition GPT. Crypsetup est actif sur une partition LVM.

On retrouve des notes techniques ainsi que divers mémo et lien. L'environnement [KDE 5 plasma](https://www.kde.org/announcements/plasma5.0/) est utilisé comme interface graphique par défaut. 

## Ressource Zenbook

* [Arch wiki page for the ASUS Zenbook UX301LA](https://wiki.archlinux.org/index.php/ASUS_UX301LA).
* [Arch wiki page for the ASUS Zenbook Prime UX31A](https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A)


Following the [USB Installation Media](https://wiki.archlinux.org/index.php/USB_Installation_Media)
guide, download the [latest install ISO](https://www.archlinux.org/download/)
and write it onto a USB stick with:

    dd bs=4M if=/path/to/archlinux.iso of=/dev/sdX && sync
