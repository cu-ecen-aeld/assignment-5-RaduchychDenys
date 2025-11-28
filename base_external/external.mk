include $(sort $(wildcard $(BR2_EXTERNAL_project_base_PATH)/package/*/*.mk))
BR2_ROOTFS_OVERLAY += $(BR2_EXTERNAL_project_base_PATH)/overlay
