new_dawn
========

## SnowBird Linux 19 Notes ##

SB19 consists of 4 files as set below:

1) fedora-live-base.ks

2) fedora-live-desktop.ks

3) fedora-repo.ks

4) fedora-cleanup.ks

-> fedora-live-base.ks is used to set the base of the distribution and modify the live image at boot time. Minimal edits are required in the file.

-> fedora-live-desktop.ks contains the major tweaks for producing the remix. Most of the customizations are specified in the file.

-> fedora-repo.ks is used to specify the repositories to be used while producing the media. All repositories should be included in the file.

-> fedora-cleanup.ks is used to clean-up/exclude unwanted packages from the build. Specify all packages to be removed in the file.


## Build Instructions ##

Create a /build/downloads folder and include the non-free software (local packages). 

Create a /build/patch folder where all other files are stored.

Some of these packages will require a manual update until I host an online repository. Once you have all the files downloaded use createrepo -v /build/downloads to create the required repository meta-data.


## Post Options ##

SB19 is based on Gnome3 so most %post options are related to the configuration of the same desktop enviroment. If you decide to add Cinnamon or the classic shell you may need to tweak the options through the dconf-editor.


## Known Bugs ##

1) The Anaconda icon (live install) seems to be missing from the gnome icon set or it may be located somewhere else now? Investigation required. No side effects, just ugly when looking at the window lists.

2) Anaconda (live install) displays the version number twice "SnowBird Linux 19 (New Dawn) 19. Investigation required. No side effects, just annoying.


## To do list ##

1) Have custom icons designed for SnowBird Linux. Time to get rid of the beefy miracle and sausages...

2) Host an online repository for non-free software.
