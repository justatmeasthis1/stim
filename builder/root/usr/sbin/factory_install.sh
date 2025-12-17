#!/bin/bash
clear
fullpath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
first2=$(echo "$fullpath" | cut -d/ -f-3)
RED='\e[31m'
RESET='\e[0m'
echo "Installed payloads, STIM, FMN, debug bash"
echo "graceless one wuz here"
sleep 3
if [ "$first2" = "/home/user" ]; then
echo -e "${RED}WARNING, DEMO MODE IS ON${RESET} what does this mean? it means that you are currently not in a factory shim and scripts may not work properly."
sleep 7
break
fi
userroot=Guest
userrootopposite=Admin
failedtries=0
infmn=0
while true; do
fullpath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
first2=$(echo "$fullpath" | cut -d/ -f-3)
GREEN='\e[32m'
YELLOW='\e[33m'
PURPLE='\033[35m'
BLUE='\e[34m'
BOLD='\e[1m'
RESET='\e[0m'
BRIGHT_BLUE='\e[96m'
SCRIPT_DATE="[dec 15 2025]"
path=FMN.sh
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
if [ "$first2" = "/home/user" ]; then
echo -e "${BRIGHT_BLUE}DEMO MODE${RESET}"
echo
fi
    echo "1) Block updates"
    echo -e "2) Go back to ${BLUE}STIM${RESET}"
    echo "3) Reboot"
    read -ep "Choose option: " choice

    case $choice in
        1)
        if [ "$first2" = "/home/user" ]; then
echo "In demo mode, cant use this right now, sorry :("
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
            echo -e "Heading to ${BLUE}STIM${RESET}"
            sleep 3
            infmn=0
            break
            ;;
        3)
         if [ "$first2" = "/home/user" ]; then
echo "In demo mode, cant use this right now, sorry :("
echo
read -ep "Press enter to return to main menu"
else
            reboot -f
            echo "for some reason u didnt reboot, weird, lets try it 10 more times!"
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
if [ "$first2" = "/home/user" ]; then
echo -e "${BRIGHT_BLUE}DEMO MODE${RESET}"
echo
fi
echo -e "Currently logged in as: ${RED}$userroot${RESET}" 
echo
echo
echo "What would you like to do?"
    echo -e "1) Goto ${YELLOW}FMN${RESET}"
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
        if [ "$first2" = "/home/user" ]; then
        clear
echo "so your computer would get bricked but since your in demo mode, your good :)"
sleep 3
failedtries=0
break
else
clear
echo "failsafe"
sleep 4380953948758934
crossystem battery_cutoff_request=1 2>/dev/null
  echo "Oh nah, you did it. You bruteforced it and got fucked in the ass for it, your computer is broken now."
  sleep 3
  echo "I hope you learned your lesson, your gonna have to goto your IT to fix it"
  sleep 5
  echo "Im not telling you how to restart your computer or fix it since you tried to brute force it."
  sleep 20
  echo "if your gonna give this computer to IT for them to try and fix it while the screen is still on, let me say this"
  sleep 1 
  echo "This student tried to use a random script hosted on the internet while not understanding the code behind it, and when they used the script, they decided to type in a random password assumming it would give them access to early access unenrollment stuff."
  echo "The script they're trying to use is a modified version of a chromeos factory shim, which means theyve downloaded illegal stuff just to get root access to laptops that they dont own. if you ask me then this is suspension worthy."
  sleep 9999999999999999999999999999
  fi
else
         clear
		echo "Login for debugging"
        echo -e "Type '1' as the pass if you wanna goto ${YELLOW}FMN${RESET} instead"
        echo -e "Failed tries ${RED}$failedtries${RESET}/3"
    read -sep "Login: " userpass
    case $userpass in
        1)
        clear
        echo -e "heading to ${YELLOW}FMN${RESET}, please wait..."
        sleep 3
        infmn=1
        break
        ;;
        
        $goon)
        userroot=Admin
        userrootopposite=Guest
        failedtries=0
        break
            ;;
        *)
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
echo -e "${RED}  ▄▄▄▄                   ${RESET}          ▄▄▄      ▄▄▄          ▄▄        ${YELLOW}  ▄▄▄▄▄▄▄ ▄▄▄      ▄▄▄ ▄▄▄    ▄▄▄ ${RESET}                 ▄▄  ${BLUE}  ▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄ ▄▄▄      ▄▄▄ "
echo -e "${RED}▄██████▄  ▀▀             ${RESET}          ████▄  ▄████          ██        ${YELLOW} ███▀▀▀▀▀ ████▄  ▄████ ████▄  ███ ${RESET}                 ██  ${BLUE} █████▀▀▀ ▀▀▀███▀▀▀  ███  ████▄  ▄████ "
echo -e "${RED}███  ███  ██ ▄███▄ ▄█▀▀▀ ${RESET}          ███▀████▀███  ▀▀█▄ ▄████ ▄█▀█▄  ${YELLOW} ███▄▄    ███▀████▀███ ███▀██▄███ ${RESET}   ▀▀█▄ ████▄ ▄████  ${BLUE}  ▀████▄     ███     ███  ███▀████▀███ "
echo -e "${RED}███▄▄███ ▀██ ██ ██ ▀███▄ ${RESET}  ▀▀▀▀▀   ███  ▀▀  ███ ▄█▀██ ██ ██ ██▄█▀  ${YELLOW} ███▀▀    ███  ▀▀  ███ ███  ▀████ ${RESET}  ▄█▀██ ██ ██ ██ ██  ${BLUE}    ▀████    ███     ███  ███  ▀▀  ███ "
echo -e "${RED} ▀████▀   ██ ▀███▀ ▄▄▄█▀ ${RESET}          ███      ███ ▀█▄██ ▀████ ▀█▄▄▄  ${YELLOW} ███      ███      ███ ███    ███ ${RESET}  ▀█▄██ ██ ██ ▀████  ${BLUE} ███████▀    ███    ▄███▄ ███      ███ "
echo -e "${RED}          ██             ${RESET}                                          ${YELLOW}                                  ${RESET}                     ${BLUE}                                      " 
echo -e "${RED}       ▀▀▀               ${RESET}                                          ${YELLOW}                                  ${RESET}                     ${BLUE}                                     ${RESET}"
echo
read -ep "press enter to return go back to the main menu :P"
;;
        4)
         if [ "$first2" = "/home/user" ]; then
echo "In demo mode, cant use this right now, sorry :("
echo
read -ep "Press enter to return to main menu"
else
            reboot -f
            echo "for some reason u didnt reboot, weird, lets try it 10 more times!"
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
if [ "$first2" = "/home/user" ]; then
echo -e "${BRIGHT_BLUE}DEMO MODE${RESET}"
echo
fi
echo -e "Currently logged in as: ${GREEN}$userroot${RESET}" 
echo ""
echo
echo "What would you like to do?"
    echo "1) Goto shell for debugging"
    echo -e "2) Login as ${RED}$userrootopposite${RESET}"
    echo "3) Reboot"
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
        echo "entering locked down mode"
        ;;
        3)
         if [ "$first2" = "/home/user" ]; then
echo "In demo mode, cant use this right now, sorry :("
echo
read -ep "Press enter to return to main menu"
else
            reboot -f
            echo "for some reason u didnt reboot, weird, lets try it 10 more times!"
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
    done
