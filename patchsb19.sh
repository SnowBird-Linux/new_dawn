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

# Change plymouth theme to solar (Amit Caleechurn)
plymouth-set-default-theme solar
dracut -f

# Enable screensaver locking
echo "" > /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.screensaver.gschema.override << FOE
[org.gnome.desktop.screensaver]
lock-enabled=true
FOE

# and show the lock screen option
echo "" > /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override
cat >> /usr/share/glib-2.0/schemas/org.gnome.desktop.lockdown.gschema.override << FOE
[org.gnome.desktop.lockdown]
disable-lock-screen=false
FOE

# Rebuild schema cache with the overrides we installed
glib-compile-schemas /usr/share/glib-2.0/schemas

# Disable some more unwanted services (Amit Caleechurn)
systemctl --no-reload disable livesys-late livesys patchsb mdmonitor multipathd 
