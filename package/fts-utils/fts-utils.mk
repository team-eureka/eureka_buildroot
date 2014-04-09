################################################################################
#
# fts-utils
#
################################################################################

FTS_UTILS_VERSION = v1
FTS_UTILS_SITE = https://github.com/team-eureka/fts-utils.git
FTS_UTILS_SITE_METHOD = git

define FTS_UTILS_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) fts-get fts-set
endef

define FTS_UTILS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/fts-set $(TARGET_DIR)/usr/sbin
	$(INSTALL) -D -m 0755 $(@D)/fts-get $(TARGET_DIR)/usr/sbin
	$(INSTALL) -D -m 0755 $(@D)/set-boot-cmd $(TARGET_DIR)/usr/sbin
endef

$(eval $(generic-package))
