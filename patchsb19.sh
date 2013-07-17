# Script to be run post installation
#
#!/bin/bash

set -o verbose

# Display system information (Amit Caleechurn)
cat <<EOF
Distribution: $(cat /etc/issue | head -n 1)
Kernel: $(uname -irs)
RAM: $(grep MemTotal /proc/meminfo | cut -c18-)
Video: $(lspci | grep VGA | cut -c36-)
Audio: $(lspci | grep Audio | cut -c23-)
Ethernet: $(lspci | grep Ethernet | cut -c30-)
Wireless: $(lspci | grep Network | cut -c29-)
EOF

# Disable some unwanted services (Amit Caleechurn)
systemctl disable livesys-late.service livesys.service abrt-uefioops.service abrt-xorg.service mdmonitor.service multipathd.service

# Set release name to SnowBird Linux (Amit Caleechurn)
sed -i -e 's/Generic release/SnowBird Linux/g' /etc/fedora-release /etc/issue /etc/issue.net
sed -i -e 's/Generic/New Dawn/g' /etc/fedora-release /etc/issue /etc/issue.net
sed -i -e 's/generic/snowbird/g' /etc/system-release-cpe

cat > /etc/os-release << FOE
NAME="SnowBird Linux"
VERSION="19 (New Dawn)"
ID=snowbird
VERSION_ID=19
PRETTY_NAME="SnowBird Linux 19 (New Dawn)"
ANSI_COLOR="0;34"
CPE_NAME="cpe:/o:snowcorp:snowbird:19"
FOE

# Set remix logo as default
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/system-logo-white.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/fedora-gdm-logo.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/fedora-logo.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/fedora-logo-small.png 
cp /usr/share/pixmaps/fedora-remix-logos/Fedora-Remix-Transparent-Strawberry.png /usr/share/pixmaps/poweredby.png

# Change plymouth theme to solar and set branding (Amit Caleechurn)
plymouth-set-default-theme solar
dracut -f

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
# Colors in Terminal
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

# Enable screensaver locking
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
lock-enabled=true
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

# Configure weather extension (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.extensions.weather.gschema.override << FOE
[org.gnome.shell.extensions.weather]
city='1377436>Port Louis, Port Louis (MU)'
position-in-panel='right'
pressure-unit='hPa'
unit='celsius'
wind-speed-unit='kph'
FOE

# Improve font rendering (Amit Caleechurn)
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

# Set font rendering (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.settings-daemon.plugins.xsettings.gschema.override << FOE
[org.gnome.settings-daemon.plugins.xsettings]
antialiasing='rgba'
hinting='medium'
FOE

# Rebuild schema cache with the overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# Make libreoffice pretty with faenza icons (Amit Caleechurn)
cp -ar images_crystal.zip /usr/lib64/libreoffice/share/config/images_tango.zip

