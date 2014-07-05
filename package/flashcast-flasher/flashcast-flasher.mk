################################################################################
#
# flashcast-flasher
#
################################################################################

FLASHCAST_FLASHER_VERSION = v1.3
FLASHCAST_FLASHER_SITE = https://github.com/team-eureka/flashcast-flasher.git
FLASHCAST_FLASHER_SITE_METHOD = git
FLASHCAST_FLASHER_LICENSE = GPLv3+
FLASHCAST_FLASHER_LICENSE_FILES = LICENSE

define FLASHCAST_FLASHER_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define FLASHCAST_FLASHER_INSTALL_TARGET_CMDS
	$(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
