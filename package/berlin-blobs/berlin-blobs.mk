################################################################################
#
# berlin-blobs
#
################################################################################

BERLIN_BLOBS_VERSION = 15250
BERLIN_BLOBS_CHECKSUM = c969d0c31d3154c9333cc4d6837ffd6696570173
BERLIN_BLOBS_SOURCE = ota.$(BERLIN_BLOBS_VERSION).stable-channel.eureka-b3.$(BERLIN_BLOBS_CHECKSUM).zip
BERLIN_BLOBS_INSTALL_STAGING = YES
BERLIN_BLOBS_SITE = http://cache.pack.google.com/edgedl/googletv-eureka/stable-channel
BERLIN_BLOBS_REDISTRIBUTE = NO

define BERLIN_BLOBS_EXTRACT_CMDS
	unzip -d $(@D) $(DL_DIR)/$(BERLIN_BLOBS_SOURCE)
	unsquashfs -d $(@D)/system $(@D)/system.img
endef

BERLIN_BLOBS_BINARIES = PE_Single_CPU
BERLIN_BLOBS_LIBRARIES = libshm.so libAudio.so directfb-1.6-0/systems/libdirectfb_mvgfx.so libPEAgent.so libCrypto.so libBoard.so libBootLogo.so libMutePrint.so libDMX.so libDrivers.so libDRM.so libPEServer.so libVideo.so libDisplay.so libOSAL.so libGFX.so

define BERLIN_BLOBS_INSTALL_STAGING_CMDS
	cd $(@D)/system/lib/ ; cp --parents $(BERLIN_BLOBS_LIBRARIES) $(STAGING_DIR)/usr/lib/
endef

define BERLIN_BLOBS_INSTALL_TARGET_CMDS
	cd $(@D)/system/bin/ ; cp --parents $(BERLIN_BLOBS_BINARIES) $(TARGET_DIR)/bin/
	cd $(@D)/system/lib/ ; cp --parents $(BERLIN_BLOBS_LIBRARIES) $(TARGET_DIR)/usr/lib/
endef

$(eval $(generic-package))
