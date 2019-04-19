# Community

* IRC: irc://irc.freenode.net/#phh-treble
* WebIRC: http://webchat.freenode.net/?channels=%23phh-treble&uio=d4
* Matrix: #freenode_#phh-treble:matrix.org
* Telegram https://t.me/phhtreble
* xda-developers threads: https://forum.xda-developers.com/search.php?do=finduser&u=1915408&starteronly=1

# How to build

* clone this repository
* call the build scripts from a separate directory

For example:

    git clone https://github.com/phhusson/treble_experimentations
    mkdir Lineage; cd Lineage
    bash ../treble_experimentations/build-ramyski.sh rr
    arm-aonly-gapps-su
    arm64-ab-go-nosu
    lunch treble_arm64_avN-userdebug
    WITHOUT_CHECK_API=true make -j8 systemimage

The script should provide a help message if you pass something it
doesn't understand

# Conventions for commit messages:

* `[UGLY]` Please make this patch disappear as soon as possible
* `[master]` tag means that the commit should be dropped in a future
  rebase
* `[device]` tag means this change is device-specific workaround
* `::device name::` will try to describe which devices are concerned
  by this change
* `[userfriendly]` This commit is NOT used for hardware support, but
  to make the rom more user friendly

@phhusson for all his contributions, without his efforts this can't be possible.
@Dakkar for This build script
