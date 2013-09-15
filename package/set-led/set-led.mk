################################################################################
#
# set-led
#
################################################################################

SET_LED_VERSION = 0.1
SET_LED_SITE = $(TOPDIR)/package/set-led/source/
SET_LED_SITE_METHOD = local

define SET_LED_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) set-led
endef

define SET_LED_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/set-led $(TARGET_DIR)/usr/sbin
endef

$(eval $(generic-package))
