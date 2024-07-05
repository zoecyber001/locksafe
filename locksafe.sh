#!/bin/bash

LOCKSAFE_IMG=~/locksafe.img
MOUNT_POINT=~/locksafe_mount
MAPPER_NAME=locksafe

function log_and_exit {
    local message=$1
    zenity --error --text="$message"
    exit 1
}

function lock_safe {
    if mountpoint -q $MOUNT_POINT; then
        if ! sudo umount $MOUNT_POINT; then
            log_and_exit "Failed to unmount $MOUNT_POINT."
        fi
        if ! sudo cryptsetup luksClose $MAPPER_NAME; then
            log_and_exit "Failed to close LUKS device $MAPPER_NAME."
        fi
        zenity --info --text="Lock safe has been locked."
    else
        zenity --info --text="Lock safe is already locked."
    fi
}

function unlock_safe {
    if [ ! -f "$LOCKSAFE_IMG" ]; then
        log_and_exit "Lock safe image $LOCKSAFE_IMG does not exist."
    fi

    if [ ! -d "$MOUNT_POINT" ]; then
        mkdir -p $MOUNT_POINT
    fi

    if ! sudo cryptsetup isLuksOpen $MAPPER_NAME > /dev/null 2>&1; then
        PASSWORD=$(zenity --password --title="Enter Password to Unlock Safe")
        echo $PASSWORD | sudo cryptsetup luksOpen $LOCKSAFE_IMG $MAPPER_NAME
        if [ $? -ne 0 ]; then
            log_and_exit "Failed to open LUKS device with provided password."
        fi
        sudo mount /dev/mapper/$MAPPER_NAME $MOUNT_POINT
        if [ $? -ne 0 ]; then
            log_and_exit "Failed to mount $MOUNT_POINT."
        fi
        sudo chown $USER:$USER $MOUNT_POINT
        zenity --info --text="Lock safe has been unlocked and mounted at $MOUNT_POINT."
    else
        zenity --info --text="Lock safe is already unlocked."
    fi
}

# Prompt user for action
action=$(zenity --list --radiolist --title="Lock/Unlock Safe" --column="" --column="Action" FALSE "Lock Safe" TRUE "Unlock Safe")

if [ "$action" == "Lock Safe" ]; then
    lock_safe
elif [ "$action" == "Unlock Safe" ]; then
    unlock_safe
else
    zenity --error --text="No action selected. Exiting."
    exit 1
fi

