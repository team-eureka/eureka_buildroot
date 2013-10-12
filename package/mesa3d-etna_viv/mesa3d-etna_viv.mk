#############################################################
#
# mesa3d
#
#############################################################

MESA3D_ETNA_VIV_VERSION = master
MESA3D_ETNA_VIV_SITE = git://github.com/laanwj/mesa.git
MESA3D_ETNA_VIV_AUTORECONF = YES
MESA3D_ETNA_VIV_INSTALL_STAGING = YES

MESA3D_ETNA_VIV_CONF_ENV = \
	AWK="$(HOST_DIR)/usr/bin/gawk" \
	LEX="$(HOST_DIR)/usr/bin/flex" \
	YACC="$(HOST_DIR)/usr/bin/bison -y" \
	LIBTOOL_FOR_BUILD="$(HOST_DIR)/usr/bin/libtool" \
	PYTHON2="$(HOST_DIR)/usr/bin/python2" \
	ETNA_LIBS="$(STAGING_DIR)/usr/lib/libetnaviv.a"

MESA3D_ETNA_VIV_CONF_OPT = \
	--enable-gles1 \
	--enable-gles2 \
	--disable-glx \
	--enable-dri --with-dri-drivers= \
	--enable-egl --with-egl-platforms=fbdev \
	--enable-gallium-egl --with-gallium-drivers=swrast,etna \
	--disable-static

ifeq ($(BR2_PACKAGE_MESA3D_ETNA_VIV_DEBUG),y)
MESA3D_ETNA_VIV_CONF_OPT += --enable-debug
endif

MESA3D_ETNA_VIV_DEPENDENCIES = \
	etna_viv \
	expat \
	libdrm \
	host-gawk \
	host-flex \
	host-bison \
	host-pkgconf \
	host-python \
	host-libxml2

$(eval $(autotools-package))
