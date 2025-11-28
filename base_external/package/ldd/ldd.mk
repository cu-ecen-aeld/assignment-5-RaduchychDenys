
LDD_VERSION = 002c1bad4adf66edc789d2e21daecf8c1f6bed2c
LDD_SITE = 'git@github.com:cu-ecen-aeld/assignment-7-RaduchychDenys.git'
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = NO
LDD_INSTALL_TARGET = YES

LDD_MODULE_SUBDIRS =

ifeq ($(MISC_MODULES), y)
LDD_MODULE_SUBDIRS += misc-modules
endif

ifeq ($(SCULL_MODULE), y)
LDD_MODULE_SUBDIRS += scull
endif


$(info *******************)
$(eval $(info SUBDIRS for LDD build:$(LDD_MODULE_SUBDIRS)))
$(info *******************)

define LDD_INSTALL_TARGET_CMDS_BASE
	@echo "Installing base LDD scripts..." \
    $(INSTALL) -d $(TARGET_DIR)/usr/bin
endef #LDD_INSTALL_TARGET_CM5

LDD_INSTALL_TARGET_CMDS += $(LDD_INSTALL_TARGET_CMDS_BASE)

LDD_PKG_DIR = $(BUILD_DIR)/ldd-$(LDD_VERSION)

ifeq ($(MISC_MODULES), y)

define LDD_INSTALL_TARGET_MISC_MODULES
	-rm -f $(TARGET_DIR)/usr/bin/module_load
	-rm -f $(TARGET_DIR)/usr/bin/module_unload
	$(INSTALL) -m 0755 $(LDD_PKG_DIR)/misc-modules/module_load $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(LDD_PKG_DIR)/misc-modules/module_unload $(TARGET_DIR)/usr/bin/

endef #LDD_INSTALL_TARGET_MISC_MODULES

LDD_INSTALL_TARGET_CMDS += $(LDD_INSTALL_TARGET_MISC_MODULES)

endif #MISC_MODULES


ifeq ($(SCULL_MODULE), y)

define LDD_INSTALL_TARGET_SCULL
	-rm -f $(TARGET_DIR)/usr/bin/scull_load
	-rm -f $(TARGET_DIR)/usr/bin/scull_unload
	$(INSTALL) -m 0755 $(LDD_PKG_DIR)/scull/scull_load $(TARGET_DIR)/usr/bin/
	$(INSTALL) -m 0755 $(LDD_PKG_DIR)/scull/scull_unload $(TARGET_DIR)/usr/bin/

endef #LDD_INSTALL_TARGET_SCULL

LDD_INSTALL_TARGET_CMDS += $(LDD_INSTALL_TARGET_SCULL)

endif #SCULL_MODULE

$(eval $(kernel-module))
$(eval $(generic-package))
