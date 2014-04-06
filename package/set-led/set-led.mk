################################################################################
#
# set-led
#
################################################################################

SET_LED_VERSION = v0.1
SET_LED_SITE = https://github.com/team-eureka/set-led.git
SET_LED_SITE_METHOD = git

define SET_LED_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) set-led
endef

define SET_LED_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/set-led $(TARGET_DIR)/usr/sbin
endef

$(eval $(generic-package))
