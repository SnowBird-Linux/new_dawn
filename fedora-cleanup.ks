# fedora-cleanup.ks
#
# Customized by Amit Caleechurn
# http://linuxmauritius.wordpress.com
# mailto:acaleechurn@fedoraproject.org

%packages

# Remove default unwanted hardware firmware and support we don't want (Amit Caleechurn)
-foomatic*
-ghostscript*
-ivtv-firmware

# These are listed somewhere other than hardware support! (Amit Caleechurn)
-irda-utils
-fprintd*

# dictionaries are big (Amit Caleechurn)
-aspell-*
-hunspell-*
-man-pages*
-words

# Remove default base packages we don't want (Amit Caleechurn)
-dos2unix
-dump
-finger
-fprintd-pam
-hunspell
-jwhois
-lftp
-mlocate
-nano
-nfs-utils
-numactl
-pcmciautils
-pm-utils
-rdate
-rdist
-rsh
-rsync
-sos
-stunnel
-time
-tree
-words
-ypbind

# Debug & unwanted (Amit Caleechurn)
-bijiben
-orca
-rhythmbox
-aisleriot
-vinagre
-eog
-totem
-totem-mozplugin
-totem-nautilus
-gnome-mplayer

# FIXME; apparently the glibc maintainers dislike this, but it got put into the
# desktop image at some point.  We won't touch this one for now.
nss-mdns

# This one needs to be kicked out of @standard
-smartmontools

# We use gnome-control-center's printer and input sources panels instead
-system-config-printer
-im-chooser

%end
