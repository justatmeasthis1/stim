#!/bin/bash

while true; do
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
BOLD='\e[1m'
RESET='\e[0m'
SCRIPT_DATE="[dec 15 2025]"
clear
echo -e "${YELLOW} ▄▄▄▄▄▄▄▄▄▄▄  ▄▄       ▄▄  ▄▄        ▄ "
echo "▐░░░░░░░░░░░▌▐░░▌     ▐░░▌▐░░▌      ▐░▌"
echo "▐░█▀▀▀▀▀▀▀▀▀ ▐░▌░▌   ▐░▐░▌▐░▌░▌     ▐░▌"
echo "▐░▌          ▐░▌▐░▌ ▐░▌▐░▌▐░▌▐░▌    ▐░▌"
echo "▐░█▄▄▄▄▄▄▄▄▄ ▐░▌ ▐░▐░▌ ▐░▌▐░▌ ▐░▌   ▐░▌"
echo "▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌▐░▌  ▐░▌  ▐░▌"
echo "▐░█▀▀▀▀▀▀▀▀▀ ▐░▌   ▀   ▐░▌▐░▌   ▐░▌ ▐░▌"
echo "▐░▌          ▐░▌       ▐░▌▐░▌    ▐░▌▐░▌"
echo "▐░▌          ▐░▌       ▐░▌▐░▌     ▐░▐░▌"
echo "▐░▌          ▐░▌       ▐░▌▐░▌      ▐░░▌"
echo -e " ▀            ▀         ▀  ▀        ▀▀ ${RESET}"
                                       
    echo "1) Block updates"
    echo -e "2) Go back to ${BLUE}STIM${RESET}"
    echo "3) Reboot"
    read -ep "Choose option: " choice

    case $choice in
        1)
            
            # get_internal take from https://github.com/applefritter-inc/BadApple-icarus
            get_internal() {
                # get_largest_cros_blockdev does not work in BadApple.
                local ROOTDEV_LIST=$(cgpt find -t rootfs) # thanks stella
                if [ -z "$ROOTDEV_LIST" ]; then
                    echo "Could not find root devices."
                    read -ep "Press Enter to return to menu..."
                    return 1
                fi
				local device_type=$(echo "$ROOTDEV_LIST" | grep -oE 'blk0|blk1|nvme|sda' | head -n 1)
                case $device_type in
                "blk0")
                    intdis=/dev/mmcblk0
                    intdis_prefix="p"
                    ;;
                "blk1")
                    intdis=/dev/mmcblk1
                    intdis_prefix="p"
                    ;;
                "nvme")
                    intdis=/dev/nvme0
                    intdis_prefix="n"
                    ;;
                "sda")
                    intdis=/dev/sda
                    intdis_prefix=""
                    ;;
                *)
                    echo "an unknown error occured. this should not have happened."
                    read -ep "Press Enter to return to menu..."
                    return 1
                    ;;
                esac
            }
            
            get_internal || continue

			get_booted_kernnum() {
                # This assumes intdis is set, which get_internal() handles later.
                if $(expr $(cgpt show -n "$intdis" -i 2 -P) > $(cgpt show -n "$intdis" -i 4 -P)); then
                    echo -n 2
                else
                    echo -n 4
                fi
            }

            get_booted_rootnum() {
	            expr $(get_booted_kernnum) + 1
            }
			
            echo "Detected internal disk: $intdis"
            
            # Create necessary directories
            mkdir -p /localroot /stateful
            
            # Mount and prepare chroot environment
            mount "${intdis}${intdis_prefix}$(get_booted_rootnum)" /localroot -o ro 2>/dev/null
            if [ $? -ne 0 ]; then
                echo "Failed to mount root partition"
                read -ep "Press Enter to return to menu..."
                continue
            fi
            
            mount --bind /dev /localroot/dev 2>/dev/null
            if [ $? -ne 0 ]; then
                echo "Failed to bind mount /dev"
                umount /localroot
                read -ep "Press Enter to return to menu..."
                continue
            fi
            
            # Modify partition attributes
            chroot /localroot cgpt add "$intdis" -i 2 -P 10 -T 5 -S 1 2>/dev/null
            if [ $? -ne 0 ]; then
                echo "Failed to modify partition attributes"
                umount /localroot/dev
                umount /localroot
                read -ep "Press Enter to return to menu..."
                continue
            fi
            
            # Use fdisk to delete partitions
            echo -e "d\n4\nd\n5\nw" | chroot /localroot fdisk "$intdis" >/dev/null 2>&1
            
            # Cleanup
            umount /localroot/dev
            umount /localroot
            rmdir /localroot
            
            crossystem disable_dev_request=1 2>/dev/null
            
            # Try to mount stateful partition
            if ! mount "${intdis}${intdis_prefix}1" /stateful 2>/dev/null; then
                mountlvm
                if [ $? -ne 0 ]; then
                    read -ep "Press Enter to return to menu..."
                    continue
                fi
            fi
            
            # Clear stateful partition
            rm -rf /stateful/*
            umount /stateful
			echo "Daub completed successfully!"
            echo "DO NOT POWERWASH IN CHROMEOS! YOUR DEVICE WILL BOOTLOOP!"
			echo "(bootloop is fixable by recovering)"
            read -ep "Press Enter to return to menu..."
            ;;
        2)
        clear
            echo -e "Heading to ${BLUE}STIM${RESET}"
            sleep 3
            source /usr/sbin/factory_install.sh
            ;;
        3)
        echo "pretend this is rebooting"
            reboot -f
            ;;
        *)
            echo "Invalid option, please try again..."
            read -ep "Press Enter to return to menu..."
            ;;
    esac
done

mountlvm(){
     vgchange -ay #active all volume groups
     volgroup=$(vgscan | grep "Found volume group" | awk '{print $4}' | tr -d '"')
     echo "found volume group:  $volgroup"
     mount "/dev/$volgroup/unencrypted" /stateful || {
         echo "couldnt mount p1 or lvm group.  Please recover"
         return 1
     }
}
