configuration
=============

# archKDE-EFI

Note de développement et script

##  Linux Distro

Installation de la distribution [archlinux](https://www.archlinux.fr/)

## Installation et configuration

Cette installation enlève entierement Windows. La configuration s'installe sur un boot UEFI et une partition GPT. Cryptsetup est actif sur une partition LVM.

On retrouve des notes techniques ainsi que divers mémo et lien. L'environnement [KDE 5 plasma](https://www.kde.org/announcements/plasma5.0/) est utilisé comme interface graphique par défaut. 

## Ressource Zenbook

* [Arch wiki page for the ASUS Zenbook UX301LA](https://wiki.archlinux.org/index.php/ASUS_UX301LA).
* [Arch wiki page for the ASUS Zenbook Prime UX31A](https://wiki.archlinux.org/index.php/ASUS_Zenbook_Prime_UX31A)

#### boot configuration

Enter the boot settings menu by holding `<F2>` at boot, and:

* Leave the SATA Mode Selection as RAID
* Disable Intel(R) Anti-Theft Technology
* Disable Secure Boot Control
* Create a new boot option
    (for the inserted Arch installer USB, booting the file `EFI/boot/loader.efi`)
    (this option may appear without manual creation)

Boot the Arch install USB by holding `Esc` on boot and choosing the Arch installer.

## Installation de ISO sur une clé USB

Quivre le guide [USB Installation Media](https://wiki.archlinux.org/index.php/USB_Installation_Media)
et télécharger l'image [Arch install ISO](https://www.archlinux.org/download/)
enfin écrire sur une clé USB .iso:

    dd bs=4M if=/path/to/archlinux.iso of=/dev/sdX && sync

## Arch base Installation

Suivre les étapes de la doc [Arch Installation Wiki](https://wiki.archlinux.fr/Installation), en particulier pour le notes de vérification d'intégrité `md5sum` algorythme de hachage et la signature PGP au moyen de `pacman-key`

Vérification de bien être sur un boot en mode UEFI en testant la variable

    efivar -l

Préparer le disque et la partition GPT avec `cgdisk`




Move a preferable mirror to the top of the list:

    nano /etc/pacman.d/mirrorlist

Install the base system:

    pacstrap -i /mnt base base devel

Generate an `fstab` file:

    genfstab -L -p /mnt >> /mnt/etc/fstab
    nano /mnt/etc/fstab   # Set last param of EFI partion to 0 (don't check)


Chroot to base system:

    arch-chroot /mnt /bin/bash

Set the locale (`en_US.UTF-8 fr_FR.UTF-8`):

    nano /etc/locale.gen
    locale-gen
    nano /etc/locale.conf
    LANG="fr_FR.UTF-8"
    LC_COLLATE="fr_FR.UTF-8"
    export LANG=fr_FR.UTF-8
    locale   # to check available vars

Définir la langue du clavier en AZERTY:

    nano /etc/vconsole.conf
    KEYMAP=fr-pc

Set localtime link to appropriate zone file:

    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

Set the hardware clock to UTC:

    hwclock --systohc --utc

NTP time synchronization with [Chrony](https://wiki.archlinux.org/index.php/Chrony):

    pacman -S chrony

Set the hostname:

    echo archtop > /etc/hostname

Edition de `rc.conf` script au démarrage

    nano /etc/rc.conf
    DAEMONS=(hwclock syslog-ng network)

Mot de passe administrateur

    passwd

Demarrage du service dhcpcd (ethernet)

    systemctl enable dhcpcd




### Post install

(........... edit pacman.conf)

Create group and user, allow to sudo:

    groupadd chris
    useradd -m -g chris -G chris,wheel -s /bin/bash chris
    chfn chris
    passwd chris
    vi /etc/sudoers   # allow users in wheel group to sudo

CPU microcode updates (need to tell Grub to load the initrd as described [on the wiki](https://wiki.archlinux.org/index.php/Microcode#Enabling_Intel_Microcode_Updates)):

    pacman -S intel-ucode

Sound:

    pacman -S alsa-utils

X Windows, 3D and video driver, touchpad, hardware accelerated video decoding:

    pacman -S xorg-server xorg-server-utils xorg-xinit xorg-twm xterm xorg-xclock
    pacman -S mesa
    pacman -S xf86-video-intel
    pacman -S xf86-input-synaptics
    pacman -S libva-intel-driver

32-bit 3D video acceleration:

    sudo pacman -S lib32-intel-dri

Couche clavier AZERTY pour xterm:
    
    nano /etc/X11/xorg.conf.d/10-keyboard-layout.conf

    Section "InputClass"
        Identifier         "Keyboard Layout"
        MatchIsKeyboard    "yes"
        Option             "XkbLayout"  "fr"
        Option             "XkbVariant" "latin9" 
    EndSection

#### Installation de KD5 plasma

Dépendance kf5 dans le repo officiel

    sudo pacman -S kf5 kf5-aids

Installation du bureau plasma via AUR:

    sudo pacman -S plasma-next

Gestionnaire de session et activation au démarrage SDDM pour [KD5 plasma](https://wiki.archlinux.org/index.php/SDDM)


    pacman -S sddm
    systemctl enable sddm

Créer un nouveau fichier de configuration en root `sudo su`

    sddm --example-config > /etc/sddm.conf

Le theme d'origine fait mal aux yeux: remplacer par [Archlinuxtheme SDDM](https://github.com/absturztaube/sddm-archlinux-theme)

    sudo yaourt -S sddm-archlinux-theme-git
    sudo nano /etc/sddm.conf
    [theme]
    Current=archlinux

Edition du fichier `~/.initrc` pour xinit session:

    exec startkde

On peut trouver des thèmes pour le bureau plasma sur [KDE-LOOK](http://kde-look.org/index.php?xsortmode=down&page=0&xcontentmode=76) et également sur [Deviant Art](http://kde-users.deviantart.com/). Pour aller plus loins et remplacer le bureau Plasma par [Be::shell](http://be-desk.deviantart.com/)

Installation de complément de kdebase & traduction française:

    sudo pacman -S  	archlinux-wallpaper kde-wallpapers kdebase-dolphin kdebase-konqueror kdebase-konsole kdebase-kwrite kde-l10n-fr

Installation de terminal alternatif [yakuake](https://wiki.archlinux.org/index.php/Yakuake) déroulant:

    sudo pacman -S yakuake

Activation de [networkManager](https://wiki.archlinux.org/index.php/NetworkManager) et configuration plugins VPN:

    sudo systemctl disable dhcpcd && sudo systemctl enable NetworkManager
    sudo pacman -S networkmanager-openvpn

### Application sous KDE

En fonction des besoins trier les applications du groupe [KDE-meta](https://www.archlinux.org/groups/x86_64/kde-meta/) 

    sudo pacman -S kde-meta-kdeplasma-addons kde-meta-kdeadmin kde-meta-kdenetwork kde-meta-kdeutils kde-meta-kdegraphics kdewebdev-kommander kdesdk-dolphin-plugins kdesdk-kapptemplate kdesdk-lokalize kdesdk-okteta kdepim-akregator

Firewalll avec [PeerGuardianLinux](http://sourceforge.net/projects/peerguardian/)

    sudo yaourt -S pgl

Application multimedia & prise de note KDE

* BasKet ( prise de note )
* Amarok ( Music player )
* Akregator ( flux RSS )

   sudo pacman -S basket amarok

