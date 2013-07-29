# Include the appropriate repo definitions

# Exactly one of the following should be uncommented

# For the master branch the following should be uncommented
# %include fedora-repo-rawhide.ks

# For non-master branches the following should be uncommented
# %include fedora-repo-non-rawhide.ks

# Main Repositories (Amit Caleechurn)
#repo --name=rawhide --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide&arch=$basearch
repo --name=fedora --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=fedora-$releasever&arch=$basearch
repo --name=updates --mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=updates-released-f$releasever&arch=$basearch
#repo --name=updates-testing --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=updates-testing-f$releasever&arch=$basearch

# Additional repos (Amit Caleechurn)
repo --name="RPMFusion Free" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-19&arch=x86_64
repo --name="RPMFusion Free - Updates" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=free-fedora-updates-released-19&arch=x86_64
repo --name="RPMFusion Non-Free" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-19&arch=x86_64
repo --name="RPMFusion Non-Free - Updates" --mirrorlist=http://mirrors.rpmfusion.org/mirrorlist?repo=nonfree-fedora-updates-released-19&arch=x86_64
repo --name="Adobe Linux X86_64" --baseurl=http://linuxdownload.adobe.com/linux/x86_64/
repo --name=google-chrome --baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
repo --name=google-talkplugin --baseurl=http://dl.google.com/linux/talkplugin/rpm/stable/$basearch
repo --name=remi --includepkgs=libdvd*,remi-release* --baseurl=http://rpms.famillecollet.com/fedora/$releasever/remi/$basearch/
repo --name="Additional Software"  --baseurl=file:///build/downloads/
