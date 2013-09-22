# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org

# Customized by Amit Caleechurn
# http://linuxmauritius.wordpress.com
# mailto:acaleechurn@fedoraproject.org

%include fedora-live-base.ks
%include fedora-cleanup.ks

part / --size 6990 --fstype=ext4

%packages

### Free World ###

# Desktop (Amit Caleechurn)
@gnome-desktop
gnome-shell-extension-places-menu
gnome-shell-extension-weather
gnome-shell-extension-window-list
gnome-shell-extension-alternate-tab
gnome-shell-extension-drive-menu
gnome-tweak-tool
gnome-activity-journal
gnome-phone-manager
gnome-schedule

alacarte

# Office (Amit Caleechurn)
@libreoffice
libreoffice-presentation-minimizer
libreoffice-wiki-publisher
openclipart
vym
cherrytree
calibre

# Implicitly include the fonts we want (Amit Caleechurn)
# The fonts group is included as a dirty fix for Anaconda!
@fonts	
liberation-mono-fonts
liberation-sans-fonts
liberation-serif-fonts
google-droid-sans-fonts
google-droid-sans-mono-fonts
google-droid-serif-fonts
dejavu-sans-fonts
dejavu-sans-mono-fonts
dejavu-serif-fonts
aajohan-comfortaa-fonts
adobe-source-sans-pro-fonts
lato-fonts
overpass-fonts

# Internet (Amit Caleechurn)
@firefox
mozilla-adblockplus
evolution-mapi
evolution-pst
evolution-rspam
evolution-rss
evolution-spamassassin
gftp
gwibber
ekiga

# Themes and icons (Amit Caleechurn)
plymouth-theme-solar
faenza-icon-theme
greybird-gtk2-theme
greybird-gtk3-theme
greybird-metacity-theme

# Virtualization (Amit Caleechurn)
#VirtualBox
#VirtualBox-guest
#kmod-VirtualBox
gnome-boxes

# Utilities (Amit Caleechurn)
nautilus-extensions
nautilus-open-terminal
nautilus-sendto
brasero-nautilus
pdfmod
shutter
cups-pdf
vino
mirall
remmina
remmina-plugins-vnc
remmina-plugins-nx
remmina-plugins-telepathy
remmina-plugins-xdmcp
remmina-plugins-gnome
remmina-plugins-rdp

# Management tools (Amit Caleechurn)
dconf-editor
systemd-ui
freeipa-client
gnome-system-log

# Development (Amit Caleechurn)
gimp 
gimp-help
gimp-data-extras 
gimp-help-browser
bluefish
rapidsvn
git
giggle
meld
font-manager
geany
gobby
gedit-plugins

# Graphics (Amit Caleechurn)
scribus
inkscape
inkscape-sozi
inkscape-docs
dia
dia-gnomeDIAicons

# Audio & Video (Amit Caleechurn)
@multimedia
clementine
gtk-recordmydesktop

# Rebranding to SnowBird Linux (Amit Caleechurn)
generic-release
generic-logos
generic-release-notes
fedora-remix-logos

### Non Free ###

# Audio & Video (Amit Caleechurn)
flash-plugin
gstreamer*-plugins-bad
gstreamer*-plugins-bad-*free
gstreamer*-plugins-bad-freeworld
gstreamer-plugins-bad-free-extras
gstreamer*-plugins-good
gstreamer*-plugins-ugly
gstreamer-plugins-entrans
gstreamer-plugins-espeak
gstreamer-plugins-fc
gstreamer-plugins-good
gstreamer-plugins-good-extras
gstreamer-plugins-ugly
gstreamer-ffmpeg
gstreamer*-libav
faad2
vlc
vlc-extras

# Utilities (Amit Caleechurn)
unrar
p7zip
p7zip-plugins
gwget
realcrypt
cabextract
xz-lzma-compat
freetype-freeworld
ike
exfat-utils
fuse-exfat

# Local Packages (Amit Caleechurn)
libdvdcss
skype
projectlibre
teamviewer
google-talkplugin
webcore-fonts
grub-customizer
google-chrome-stable
google-earth-stable
opera
HandBrake-gui
hamster-time-tracker
rosa-media-player
bleachbit
flareget
flaremonitor

%end

%post --nochroot

# Stage patch (Amit Caleechurn)
mkdir $INSTALL_ROOT/opt/patch
cp -r /build/patch/* $INSTALL_ROOT/opt/patch

%end

%post

# Set release name to SnowBird Linux (Amit Caleechurn)
sed -i -e 's/Generic release/SnowBird Linux/g' /etc/fedora-release /etc/issue /etc/issue.net
sed -i -e 's/Generic/New Dawn/g' /etc/fedora-release /etc/issue /etc/issue.net
sed -i 's/generic/snowbird/g' /etc/system-release-cpe

cat > /etc/os-release << FOE
NAME="SnowBird Linux"
VERSION="19 (New Dawn)"
ID=snowbird
VERSION_ID=19
PRETTY_NAME="SnowBird Linux 19 (New Dawn)"
ANSI_COLOR="0;34"
CPE_NAME="cpe:/o:sblabs:snowbird:19"
FOE

# Set remix logo as default (Amit Caleechurn)
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/system-logo-white.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/fedora-gdm-logo.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/fedora-logo.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/fedora-logo-small.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/poweredby.png

# Make libreoffice pretty with faenza icons (Amit Caleechurn)
cp  /opt/patch/images_crystal.zip /usr/lib64/libreoffice/share/config/images_tango.zip
/sbin/restorecon /usr/lib64/libreoffice/share/config/images_tango.zip

#Fix Calibre menu entry
sed -i 's/calibre %F/Calibre/g' /usr/share/applications/calibre-gui.desktop

# Add link to the Inkscape course (Amit Caleechurn)
cat >> /usr/share/applications/inkscape-course.desktop << FOE
[Desktop Entry]
Name=Introduction To Inkscape
GenericName=Inkscape Course
Comment=Materials from Máirín Duffy's Inkscape Class
Exec=xdg-open http://linuxgrrl.com/learn/Introduction_To_Inkscape
Type=Application
Icon=fedora-logo-icon
Categories=Graphics
FOE
chmod a+x /usr/share/applications/inkscape-course.desktop

# Add colours to terminal (Amit Caleechurn)
cat <<EOF | tee -a /etc/bashrc > /dev/null 2>&1
# Colours in Terminal
if [ \$USER = root ]; then
PS1='\[\033[1;31m\][\u@\h \W]\\$\[\033[0m\] '
else
PS1='\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\]\[\033[1;32m\]\\$\[\033[m\] '
fi
EOF

# Disable auto-download-updates (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.plugins.updates.gschema.override << FOE
[org.gnome.settings-daemon.plugins.updates]
active=true
auto-download-updates=false
FOE

# Always use location in nautilus (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.nautilus.preferences.gschema.override << FOE
[org.gnome.nautilus.preferences]
always-use-location-entry=true
FOE

# Show desktop icons (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.background.gschema.override << FOE
[org.gnome.desktop.background]
picture-uri='file:///usr/share/themes/Adwaita/backgrounds/adwaita-timed.xml'
show-desktop-icons=true
FOE

# Set icon theme (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.override << FOE
[org.gnome.desktop.interface]
icon-theme='Faenza'
buttons-have-icons=true
enable-animations=true
menus-have-icons=true
clock-show-date=true
FOE

# Enable tap to click (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon-peripherals.touchpad.gschema.override << FOE
[org.gnome.settings-daemon-peripherals.touchpad]
tap-to-click=true
natural-scroll=true
FOE

# Set window theme (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.wm.preferences.gschema.override << FOE
[org.gnome.desktop.wm.preferences]
theme='Greybird'
disable-workarounds=true
FOE

# Disable screensaver locking
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
lock-enabled=false
FOE

# and hide the lock screen option
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override << FOE
[org.gnome.desktop.lockdown]
disable-lock-screen=true
FOE

# Show week date (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.calendar.gschema.override << FOE
[org.gnome.shell.calendar]
show-weekdate=true
FOE

# Show all buttons (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.overrides.gschema.override << FOE
[org.gnome.shell.overrides]
button-layout=':minimize,maximize,close'
FOE

# Favourite applications and shell customization (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.gschema.override << FOE
[org.gnome.shell]
favorite-apps=['firefox.desktop', 'evolution.desktop', 'empathy.desktop', 'vlc.desktop', 'shotwell.desktop', 'libreoffice-writer.desktop', 'nautilus.desktop', 'gnome-documents.desktop', 'anaconda.desktop']
always-show-log-out=true
enabled-extensions=['alternate-tab@gnome-shell-extensions.gcampax.github.com', 'places-menu@gnome-shell-extensions.gcampax.github.com', 'weather-extension@xeked.com', 'window-list@gnome-shell-extensions.gcampax.github.com', 'drive-menu@gnome-shell-extensions.gcampax.github.com']
FOE

# Window list extension (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.extensions.window-list.gschema.override << FOE
[org.gnome.shell.extensions.window-list]
grouping-mode=always
FOE

# Configure weather (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.Weather.Application.gschema.override << FOE
[org.gnome.Weather.Application]
locations=[<(uint32 1, <('Port Louis', 'FIMP', true, @m(dd) (-0.35662893800641049, 1.0064732078011609), @m(dd) (-0.35189230640271557, 1.0035449292887497))>)>]
FOE

# Configure Gweather (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.Gweather.gschema.override << FOE
[org.gnome.Gweather]
distance-unit='km'
pressure-unit='hpa'
speed-unit='kph'
temperature-unit='centigrade'
FOE

# Weather extension (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.extensions.weather.gschema.override << FOE
[org.gnome.shell.extensions.weather]
city='1377436>Port Louis, Port Louis (MU)'
position-in-panel='right'
pressure-unit='hPa'
unit='celsius'
wind-speed-unit='kph'
FOE

# Font config (Amit Caleechurn)
cat <<FOE | tee /etc/fonts/local.conf > /dev/null 2>&1
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
<match target="font">
<edit name="autohint" mode="assign">
<bool>true</bool>
</edit>
<edit name="hinting" mode="assign">
<bool>true</bool>
</edit>
<edit mode="assign" name="hintstyle">
<const>hintslight</const>
</edit>
</match>
</fontconfig>
FOE

# Improve font rendering (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.plugins.xsettings.gschema.override << FOE
[org.gnome.settings-daemon.plugins.xsettings]
antialiasing='rgba'
hinting='medium'
FOE

# Rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

cat >> /etc/rc.d/init.d/livesys << EOF

# Change nobody to somebody (Amit Caleechurn)
mkdir -p /var/lib/AccountsService/icons
cp /usr/share/pixmaps/faces/lightning.jpg /var/lib/AccountsService/icons/liveuser

mkdir -p /var/lib/AccountsService/users
cat >> /var/lib/AccountsService/users/liveuser << FOE
[User]
Language=en_US.utf8
XSession=
Icon=/var/lib/AccountsService/icons/liveuser
SystemAccount=false
FOE

# Set up auto-login
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
FOE

/sbin/restorecon -R /var/lib/AccountsService

# Make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

EOF

# SnowBird Linux Patch (Amit Caleechurn)
cat > /etc/rc.d/init.d/patchsb << EOF
#!/bin/bash
#
# Patch SB: Applies all the fixes present on the live environment
#
# chkconfig: 345 99 02
# description: SnowBird Linux Patch

# Firstrun check
if [ -d /home/liveuser ]; then
    exit 0
fi

if [ -e "$HOME/.config/sbl-firstrun" ]; then
    chkconfig patchsb off
    exit 0
fi

# Apply the patch
if [ ! -f "$HOME/.config/sbl-firstrun" ]; then
    touch $HOME/.config/sbl-firstrun
    sh /opt/patch/patchsb19.sh
fi

EOF

chmod 755 /etc/rc.d/init.d/patchsb
/sbin/restorecon /etc/rc.d/init.d/patchsb
/sbin/chkconfig --add patchsb

### Setup additional repositories ###

# Import RPM-GPG keys (Amit Caleechurn)
for key in $(ls /etc/pki/rpm-gpg/RPM-GPG-KEY-*) ; do
   rpmkeys --import $key
done

# OpenPrinting/Database/DriverPackages based on the LSB 3.2 (Amit Caleechurn)
cat > /etc/yum.repos.d/openprinting-drivers.repo << OPENPRINTING_REPO_EOF
[openprinting-drivers-main]
name=OpenPrinting LSB-based driver packages
baseurl=http://www.openprinting.org/download/printdriver/components/lsb3.2/main/RPMS
enabled=1
gpgcheck=0

[openprinting-drivers-contrib]
name=OpenPrinting LSB-based driver packages
baseurl=http://www.openprinting.org/download/printdriver/components/lsb3.2/contrib/RPMS
enabled=1
gpgcheck=0

[openprinting-drivers-main-nonfree]
name=OpenPrinting LSB-based driver packages
baseurl=http://www.openprinting.org/download/printdriver/components/lsb3.2/main-nonfree/RPMS
enabled=1
gpgcheck=0
OPENPRINTING_REPO_EOF

# A reduced version of Remi repository (Amit Caleechurn)
cat > /etc/yum.repos.d/remix.repo << REMI_REPO_EOF
[remix-remi]
name=Remix Remi - Fedora \$releasever - \$basearch
mirrorlist=http://rpms.famillecollet.com/fedora/\$releasever/remi/mirror
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-remi
failovermethod=priority
includepkgs=libdvd*,remi-release*
REMI_REPO_EOF

# Russian Fedora repositories (Amit Caleechurn)

cat > /etc/yum.repos.d/russian-fedora.repo << RUSSIAN_FEDORA_REPO_EOF

[russianfedora-free]
name=Russian Fedora for Fedora $releasever - Free
#baseurl=http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/fedora/releases/$releasever/Everything/$basearch/os
mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-19&arch=x86_64
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-russianfedora-free-fedora
includepkgs=basketpwd,rosa-media-player,chromedriver,chromium,grub-customizer

[russianfedora-free-updates]
name=Russian Fedora for Fedora $releasever - Free - Updates
#baseurl=http://mirror.yandex.ru/fedora/russianfedora/russianfedora/free/fedora/updates/$releasever/$basearch
mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=free-fedora-updates-released-19&arch=x86_64
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-russianfedora-free-fedora
includepkgs=basketpwd,rosa-media-player,chromedriver,chromium,grub-customizer

[russianfedora-nonfree]
name=Russian Fedora for Fedora $releasever - Nonfree
#baseurl=http://mirror.yandex.ru/fedora/russianfedora/russianfedora/nonfree/fedora/releases/$releasever/Everything/$basearch/os
mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-19&arch=x86_64
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-russianfedora-nonfree-fedora
includepkgs=opera-*

[russianfedora-nonfree-updates]
name=Russian Fedora for Fedora $releasever - Nonfree - Updates
#baseurl=http://mirror.yandex.ru/fedora/russianfedora/russianfedora/nonfree/fedora/updates/$releasever/$basearch
mirrorlist=http://mirrors.rfremix.ru/mirrorlist?repo=nonfree-fedora-updates-released-19&arch=x86_64
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-russianfedora-nonfree-fedora
includepkgs=opera-*

RUSSIAN_FEDORA_REPO_EOF

### Clean-up and Optimization process ### (Amit Caleechurn)

# Enable name resolution
set -o verbose
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
# Update the packages if required 
yum --nogpgcheck update -y
# Clean-up
rm -f /var/log/yum.log
yum clean all
# Prepare package metadata
yum check-update
# Clean up resolv.conf
echo "" > /etc/resolv.conf

# Remove unwanted menu entries
mkdir -p /opt/backups
mv /usr/share/applications/bleachbit-root.desktop /opt/backups
mv /usr/share/applications/calibre-ebook-viewer.desktop /opt/backups
mv /usr/share/applications/calibre-lrfviewer.desktop /opt/backups
mv /usr/share/applications/mailnag_config.desktop /opt/backups
mv /usr/share/applications/evolution-rss.desktop /opt/backups

%end
