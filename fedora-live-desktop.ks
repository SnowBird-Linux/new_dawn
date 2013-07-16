# Maintained by the Fedora Desktop SIG:
# http://fedoraproject.org/wiki/SIGs/Desktop
# mailto:desktop@lists.fedoraproject.org
#
# Customized by Amit Caleechurn
# http://linuxmauritius.wordpress.com
# mailto:acaleechurn@fedoraproject.org

%include fedora-live-base.ks
%include fedora-cleanup.ks

part / --size 6990 --fstype=ext4

%packages

# Desktop
@gnome-desktop
@multimedia
gnome-shell-extension-places-menu
gnome-shell-extension-weather
gnome-shell-extension-window-list
gnome-shell-extension-alternate-tab
gnome-shell-extension-drive-menu
faenza-icon-theme
greybird-gtk2-theme
greybird-gtk3-theme
greybird-metacity-theme
gnome-system-log
gnome-tweak-tool

# Office
@libreoffice
libreoffice-presentation-minimizer
libreoffice-wiki-publisher
openclipart
vym
cherrytree

# Implicitly include the fonts we want (Amit Caleechurn)
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

# Internet
@firefox
mozilla-adblockplus
gftp
gwibber

# Splash theme (Amit Caleechurn)
plymouth-theme-solar

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

# Development (Amit Caleechurn)
gimp 
gimp-help
gimp-data-extras 
gimp-help-browser
bluefish
rapidsvn
git
meld
font-manager
geany

# Graphics (Amit Caleechurn)
scribus
inkscape
inkscape-sozi
inkscape-docs
dia
dia-gnomeDIAicons

# Audio & Video (Amit Caleechurn)
banshee

### Non Free (Amit Caleechurn)###

# Audio & Video
flash-plugin
gstreamer-ffmpeg
gstreamer-plugins-entrans
gstreamer-plugins-espeak
gstreamer-plugins-fc
gstreamer-plugins-good
gstreamer-plugins-good-extras
gstreamer-plugins-ugly
gstreamer-plugins-bad
gstreamer-plugins-bad-free
gstreamer-plugins-bad-free-extras
gstreamer-plugins-bad-nonfree
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

# Local Packages (Amit Caleechurn)
libdvdcss
skype
projectlibre
teamviewer
google-talkplugin
webcore-fonts
grub-customizer
google-chrome-stable
opera
HandBrake-gui
hamster-time-tracker

# Rebranding to SnowBird Linux (Amit Caleechurn)
-fedora-logos
-fedora-release
-fedora-release-notes
generic-release
generic-logos
generic-release-notes
fedora-remix-logos

%end

%post

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

# Add link to the Inkscape Course (Amit Caleechurn)
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

cat >> /etc/rc.d/init.d/livesys << EOF

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

# Set Window theme (Amit Caleechurn)
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

# Weather extension (Amit Caleechurn)
cat >> /usr/share/glib-2.0/schemas/org.gnome.shell.extensions.weather.gschema.override << FOE
[org.gnome.shell.extensions.weather]
city='1377436>Port Louis, Port Louis (MU)'
position-in-panel='right'
pressure-unit='hPa'
unit='celsius'
wind-speed-unit='kph'
FOE

# Configure Weather (Amit Caleechurn)
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

# Rebuild schema cache with any overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# Make the installer show up
if [ -f /usr/share/applications/liveinst.desktop ]; then
  # Show harddisk install in shell dash
  sed -i -e 's/NoDisplay=true/NoDisplay=false/' /usr/share/applications/liveinst.desktop ""
  # need to move it to anaconda.desktop to make shell happy
  mv /usr/share/applications/liveinst.desktop /usr/share/applications/anaconda.desktop

# Set up auto-login
cat > /etc/gdm/custom.conf << FOE
[daemon]
AutomaticLoginEnable=True
AutomaticLogin=liveuser
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

gsettings set org.gnome.settings-daemon.plugins.xsettings antialiasing rgba
gsettings set org.gnome.settings-daemon.plugins.xsettings hinting slight

# Turn off PackageKit-command-not-found while uninstalled
if [ -f /etc/PackageKit/CommandNotFound.conf ]; then
  sed -i -e 's/^SoftwareSourceSearch=true/SoftwareSourceSearch=false/' /etc/PackageKit/CommandNotFound.conf
fi

EOF

%end