
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################


AESD_ASSIGNMENTS_VERSION = 'ed170749178c2b24ab0b0af1bc6afa7fad22d928'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-RaduchychDenys.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
    $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
endef

define AESD_ASSIGNMENTS_CREATE_DIRECTORIES
    mkdir -p $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
    $(INSTALL) -m 0766 $(@D)/server/start-stop-daemon.sh $(TARGET_DIR)/etc/init.d/S99aesdsocket

#Adding my custom executables and sripts to the bin directory
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/bin
    $(INSTALL) -m 0766 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
