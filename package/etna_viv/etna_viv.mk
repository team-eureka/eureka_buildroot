#############################################################
#
# etna_viv
#
#############################################################
ETNA_VIV_VERSION = master
ETNA_VIV_SITE = git://github.com/laanwj/etna_viv.git
ETNA_VIV_INSTALL_STAGING = YES
ETNA_VIV_DEPENDENCIES = libpng

ifeq ($(BR2_PACKAGE_ETNA_VIV_ABIV2),y)
ETNA_VIV_ABI = v2
else ifeq ($(BR2_PACKAGE_ETNA_VIV_ABIV4),y)
ETNA_VIV_ABI = v4_uapi
else ifeq ($(BR2_PACKAGE_ETNA_VIV_ABI_EUREKA),y)
ETNA_VIV_ABI = eureka
else ifeq ($(BR2_PACKAGE_ETNA_VIV),y)
$(error No ABI version selected)
endif

ifeq ($(BR2_PACKAGE_ETNA_VIV_PROFILER),y)
ETNA_VIV_PROFILER = 1
else
ETNA_VIV_PROFILER = 0
endif


define ETNA_VIV_BUILD_CMDS
	$(MAKE1) -C $(@D)/src \
		GCCPREFIX="$(TARGET_CROSS)" \
		PLATFORM_CFLAGS="-D_POSIX_C_SOURCE=200809 -D_GNU_SOURCE -DLINUX" \
		PLATFORM_CXXFLAGS="-D_POSIX_C_SOURCE=200809 -D_GNU_SOURCE -DLINUX" \
		PLATFORM_LDFLAGS="-ldl -lpthread" \
		GCABI="$(ETNA_VIV_ABI)" \
		ETNAVIV_PROFILER="$(ETNA_VIV_PROFILER)"
endef

define ETNA_VIV_INSTALL_STAGING_CMDS
	cp $(@D)/src/etnaviv/libetnaviv.a $(STAGING_DIR)/usr/lib
	mkdir -p $(STAGING_DIR)/usr/include/etnaviv
	cp $(@D)/src/etnaviv/*.h $(STAGING_DIR)/usr/include/etnaviv
endef

ETNA_VIV_DEMOS += $(wildcard $(@D)/src/fb/*.c)
ETNA_VIV_DEMOS += $(wildcard $(@D)/src/test2d/*.c)

define ETNA_VIV_INSTALL_TARGET_CMDS
	cp $(patsubst %.c,%,$(ETNA_VIV_DEMOS)) $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
