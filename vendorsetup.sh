#
# Copyright (C) 2024 The Android Open Source Project
# Copyright (C) 2024 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

FDEVICE="X690B"
#set -o xtrace

fox_get_target_device() {
	local chkdev=$(echo "$BASH_SOURCE" | grep -w $FDEVICE)
	if [ -n "$chkdev" ]; then
		FOX_BUILD_DEVICE="$FDEVICE"
	else
		chkdev=$(set | grep BASH_ARGV | grep -w $FDEVICE)
		[ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
	fi
}

if [ -z "$1" ] && [ -z "$FOX_BUILD_DEVICE" ]; then
	fox_get_target_device
fi

if [ "$1" = "$FDEVICE" ] || [  "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
		# Version / Maintainer infos
		export OF_MAINTAINER="TechySkills"
		export FOX_VERSION=R11.0
		export FOX_BUILD_TYPE="Stable"

		# Device info
		export TARGET_DEVICE_ALT="Infinix-X690B,Infinix-X690"

		# Display / Leds
		export OF_SCREEN_H="2400"
		export OF_STATUS_H="80"
		export OF_STATUS_INDENT_LEFT=48
		export OF_STATUS_INDENT_RIGHT=48
		export OF_CLOCK_POS=1

 		# Removes the loop block errors after flashing ZIPs (Workaround)
 		export OF_LOOP_DEVICE_ERRORS_TO_LOG=1

		# Other OrangeFox configs
		export OF_ENABLE_LPTOOLS=1
		export OF_ALLOW_DISABLE_NAVBAR=0
		export OF_QUICK_BACKUP_LIST="/boot;/data;"
 		export FOX_ENABLE_APP_MANAGER=1
		export FOX_USE_TWRP_RECOVERY_IMAGE_BUILDER=1
    	export TW_DEFAULT_LANGUAGE="en"
		export OF_USE_SYSTEM_FINGERPRINT=1
 		export OF_SKIP_MULTIUSER_FOLDERS_BACKUP=1
 		export FOX_DELETE_AROMAFM=1
   		export FOX_REMOVE_BASH=1

		# Run a process after formatting data to work-around MTP issues
		export OF_RUN_POST_FORMAT_PROCESS=1

	    # let's see what are our build VARs
if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
        export | grep "FOX" >> $FOX_BUILD_LOG_FILE
        export | grep "OF_" >> $FOX_BUILD_LOG_FILE
        export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
        export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi

fi
#

COMMON_LUNCH_CHOICES := \
    ofox_X690B-user \
    ofox_X690B-userdebug \
    ofox_X690B-eng
