#############################################################
#
# zip
#
#############################################################

ZIP_VERSION = 30
ZIP_SOURCE = zip$(ZIP_VERSION).tar.gz
ZIP_SITE = hivelocity.dl.sourceforge.net/infozip/Zip%203.x%20%28latest%29/3.0
ZIP_DEPENDENCIES = bzip2

define ZIP_BUILD_CMDS
  $(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC_NOCCACHE)" CPP=$(TARGET_CROSS)cpp RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" STRIP="$(TARGET_STRIP)" -C $(@D) -f unix/Makefile generic
endef

define ZIP_INSTALL_TARGET_CMDS
  $(INSTALL) -D -m 0755 $(@D)/zip $(TARGET_DIR)/usr/sbin
endef

$(eval $(generic-package))
