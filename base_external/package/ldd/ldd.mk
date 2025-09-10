
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
###LDD_VERSION = 7ee0e1a5534b00f71a14609fbb1e1d2185b8c01f
LDD_VERSION = dabb967100f47eb2b7a551adb2c72c5893c4b5c9 
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-mortuomo.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES
LDD_LICENSE = GPL-2.0
LDD_LICENSE_FILES = COPYING

# as per buildroot docs
LDD_MODULE_SUBDIRS = misc-modules/ scull/
LDD_MODULE_MAKE_OPTS = KVERSION=$(LINUX_VERSION_PROBED)

LDD_INSTALL_PATH = /lib/modules/$(LINUX_VERSION_PROBED)/ldd-modules/

define newline


endef

define LDD_INSTALL_TARGET_CMDS
	$(foreach subdir,$(LDD_MODULE_SUBDIRS), \
		$(INSTALL) -d $(TARGET_DIR)/$(LDD_INSTALL_PATH)/$(subdir)$(newline) \
		$(INSTALL) -m 0755 $(@D)/$(subdir)/*.ko $(TARGET_DIR)/$(LDD_INSTALL_PATH)/$(subdir)/$(newline) \
		$(INSTALL) -m 0755 $(@D)/$(subdir)/*load $(TARGET_DIR)/$(LDD_INSTALL_PATH)/$(subdir)/$(newline) \
	)	
endef

$(eval $(kernel-module))
$(eval $(generic-package))
