#############################################################
#
# unzip
#
#############################################################

UNZIP_VERSION = 60
UNZIP_SOURCE = unzip$(UNZIP_VERSION).tar.gz
UNZIP_SITE = hivelocity.dl.sourceforge.net/infozip/UnZip%206.x%20%28latest%29/UnZip%206.0
UNZIP_DEPENDENCIES = bzip2

define UNZIP_BUILD_CMDS
  $(TARGET_MAKE_ENV) $(MAKE) CC="$(TARGET_CC_NOCCACHE)" CPP=$(TARGET_CROSS)cpp RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" STRIP="$(TARGET_STRIP)" -C $(@D) -f unix/Makefile generic
endef

define UNZIP_INSTALL_TARGET_CMDS
  $(INSTALL) -D -m 0755 $(@D)/unzip $(TARGET_DIR)/usr/sbin
endef

$(eval $(generic-package))
