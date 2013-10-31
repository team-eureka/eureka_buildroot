################################################################################
#
# flashcast-flasher
#
################################################################################

FLASHCAST_FLASHER_VERSION = master
FLASHCAST_FLASHER_SITE = https://github.com/tchebb/flashcast-flasher.git
FLASHCAST_FLASHER_SITE_METHOD = git

define FLASHCAST_FLASHER_INSTALL_TARGET_CMDS
	$(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
