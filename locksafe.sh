#!/bin/bash

LOCKSAFE_IMG=~/locksafe.img
MOUNT_POINT=~/locksafe_mount
MAPPER_NAME=locksafe

function log_and_exit {
    local message=$1
    zenity --error --text="$message"
    exit 1
}

function create_safe {
    SIZE=$(zenity --entry --title="Create Lock Safe" --text="Enter size of the safe (e.g., 100M, 1G):")
    if [ -z "$SIZE" ]; then
        log_and_exit "No size specified. Exiting."
    fi

    if [ -f "$LOCKSAFE_IMG" ]; then
        zenity --question --text="A safe already exists. Overwrite?"
        if [ $? -ne 0 ]; then
            exit 1
        fi
        rm -f "$LOCKSAFE_IMG"
    fi

    dd if=/dev/zero of="$LOCKSAFE_IMG" bs=1 count=0 seek=$SIZE status=progress || log_and_exit "Failed to create safe file."
    sudo cryptsetup luksFormat "$LOCKSAFE_IMG" || log_and_exit "Failed to format safe with LUKS."
    zenity --info --text="Safe created successfully. Now unlock it to use."
}

function lock_safe {
    if mountpoint -q "$MOUNT_POINT"; then
        if ! sudo umount "$MOUNT_POINT"; then
            log_and_exit "Failed to unmount $MOUNT_POINT."
        fi
        if ! sudo cryptsetup luksClose "$MAPPER_NAME"; then
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
        mkdir -p "$MOUNT_POINT"
    fi

    PASSWORD=$(zenity --password --title="Enter Password to Unlock Safe")
    echo "$PASSWORD" | sudo cryptsetup luksOpen "$LOCKSAFE_IMG" "$MAPPER_NAME" || log_and_exit "Failed to open LUKS device with provided password."
    sudo mount "/dev/mapper/$MAPPER_NAME" "$MOUNT_POINT" || log_and_exit "Failed to mount $MOUNT_POINT."
    sudo chown "$USER:$USER" "$MOUNT_POINT"
    zenity --info --text="Lock safe has been unlocked and mounted at $MOUNT_POINT."
}

# Prompt user for action
action=$(zenity --list --radiolist --title="LockSafe Menu" --column="" --column="Action" \
    FALSE "Create Safe" \
    FALSE "Lock Safe" \
    TRUE "Unlock Safe")

case "$action" in
    "Create Safe")
        create_safe
        ;;
    "Lock Safe")
        lock_safe
        ;;
    "Unlock Safe")
        unlock_safe
        ;;
    *)
        zenity --error --text="No valid action selected. Exiting."
        exit 1
        ;;
esac
