This repository contains a buildroot board definition, set of defconfigs, and
various packages which together enable images to be built for the Google
Chromecast dongle, codenamed "eureka."

There are currently three defconfigs, which use the same board definition but
different packages and package configurations. The `basic` configuration will
build a bare-bones configuration, with an SSH server and packages which enable
hardware features, but nothing else. It is suitable for copying to create your
own configuration. The `flasher` configuration builds FlashCast, a recovery-
like USB image which is designed for simple imaging of the device. The
`fb-devel` configuration is for testing development of an open-source graphics
stack for the Marvell Armada 1500 SoC. The kernel patches which enable it to
be built are not yet in this repository.
