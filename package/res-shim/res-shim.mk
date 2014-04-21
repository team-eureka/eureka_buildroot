################################################################################
#
# res-shim
#
################################################################################

RES_SHIM_VERSION = v1
RES_SHIM_SITE = https://github.com/team-eureka/res-shim.git
RES_SHIM_SITE_METHOD = git
RES_SHIM_DEPENDENCIES = berlin-blobs

define RES_SHIM_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) shim
endef

define RES_SHIM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/shim $(TARGET_DIR)/usr/bin/res-shim
	$(INSTALL) -D -m 0755 package/res-shim/directfbrc $(TARGET_DIR)/etc
	$(INSTALL) -D -m 0755 package/res-shim/S30res-shim $(TARGET_DIR)/etc/init.d
endef

$(eval $(generic-package))
