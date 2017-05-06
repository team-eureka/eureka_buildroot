This repository contains an external tree for Buildroot that adds a board
definition, defconfigs, and various packages needed to support the 1st-
generation Google Chromecast streaming player, codenamed "eureka." This tree
has been tested with Buildroot 2017.02.2, but it is likely to also work with
later versions.

Setup
-----

Older versions of this repository required you to manually overlay the files
on a stock Buildroot tree. That is no longer the case and will likely not work
if you try it. Instead, we now use Buildroot's `BR2_EXTERNAL` mechanism to keep
the Chromecast's configuration in a directory separate from Buildroot's source.

NOTE: Buildroot's `BR2_EXTERNAL` mechanism changed slightly in 2016.11, and this
repository will not work with older versions.

To set up a build environment, clone this repository and Buildroot into separate
directories. Then, in your Buildroot directory, run the following command:

	BR2_EXTERNAL=<eureka_buildroot> make eureka_<config>_defconfig

where `<eureka_buildroot>` is the path where you cloned this repository (either
absolute or relative to Buildroot's source directory), and `<config>` is one of
the defconfig names described below. Buildroot will save the value of
`$BR2_EXTERNAL` to a file named `.br-external`, which means you need not set
`$BR2_EXTERNAL` on subsequent invocations of `make`.

Once you've set up the environment like this, you can use Buildroot as normal
(i.e. `make menuconfig` to alter configuration, `make` to do a full build, etc).

Configurations
--------------

There are currently three defconfigs, with differing sets of packages and
configurations. The `basic` defconfig will build a bare-bones configuration,
with an SSH server and packages which enable hardware features, but nothing
else. It is suitable as a minimal environment to explore the hardware or as
a base for custom configurations. The `flashcast` configuration builds
FlashCast, a recovery-like USB image which is designed for simple imaging of
the device. The `fb-devel` configuration is for testing development of an
open-source graphics stack for the Marvell Armada 1500 Mini SoC (i.e. Berlin
BG2CD). The kernel patches which enable it to be built are not yet in this
repository.

Dependencies
------------

In addition to the standard Buildroot dependencies, to run the post-build
scripts which create flashable images, you will need Android's `mkbootimg`
utility in your `$PATH` as well as all the scripts from my `chromecast-tools`
repository.
