
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = 7cffacb3eb2fe1bb291ed694f75408cf985734c7
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-mortuomo.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES


# assumed to be just one, fix AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS and AESD_ASSIGNMENTS_MODULE_INSTALL_PATH if this changes
AESD_ASSIGNMENTS_MODULE_SUBDIRS = aesd-char-driver/ 
AESD_ASSIGNMENTS_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)
# for internal use
AESD_ASSIGNMENTS_MODULE_INSTALL_PATH = /lib/modules/$(LINUX_VERSION_PROBED)/$(AESD_ASSIGNMENTS_MODULE_SUBDIRS)

# original was make all 
# but finder-app/Makefile is not supposed to have an all target
define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket

	$(INSTALL) -d $(TARGET_DIR)/$(AESD_ASSIGNMENTS_MODULE_INSTALL_PATH)
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar*load $(TARGET_DIR)/$(AESD_ASSIGNMENTS_MODULE_INSTALL_PATH)
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/aesdchar.ko $(TARGET_DIR)/$(AESD_ASSIGNMENTS_MODULE_INSTALL_PATH)
	$(INSTALL) -m 0755 $(@D)/aesd-char-driver/S98aesdchardriver $(TARGET_DIR)/etc/init.d

endef

$(eval $(kernel-module))
$(eval $(generic-package))
