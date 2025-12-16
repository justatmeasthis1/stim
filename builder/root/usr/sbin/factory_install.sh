#!/bin/bash
userroot=Guest
userrootopposite=Admin
failedtries=0
while true; do
RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
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
echo -e "Currently logged in as: ${RED}$userroot${RESET}" 
echo
echo
echo "What would you like to do?"
    echo -e "1) Goto ${YELLOW}FMN${RESET}"
    echo -e "2) Login as ${GREEN}$userrootopposite${RESET}"
    echo "3) Creds :)"
    read -ep "Choose option: " userchoice

    case $userchoice in
        1)
        clear
    echo -e "Heading to ${YELLOW}FMN${RESET}, please wait..."
    Sleep 3
    source /usr/sbin/FMN.sh
    ;;
        2)
        while true; do
        if [ $failedtries = 3 ]; then
        
  echo "Oh nah, you did it. You bruteforced it and got fucked in the ass for it, your computers getting bricked now"
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
  
else
         clear
		echo "Login for debugging"
        echo -e "Type '1' as the pass if you wanna goto ${YELLOW}FMN${RESET} instead"
        echo -e "Failed tries ${RED}$failedtries${RESET}/3"
    read -ep "Login: " userpass
    case $userpass in
        1)
        clear
        echo -e "heading to ${YELLOW}FMN${RESET}, please wait..."
        sleep 3
        source /usr/sbin/FMN.sh
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
echo -e "${GREEN}                                                            %%%%%%%#######################%%%%%%%%%%"${RESET}
echo -e "${GREEN}                                                     %%%###################*###########################%%%%"${RESET}
echo -e "${GREEN}                                               %%%###########*****++=====----===========++++******###########%%%%"${RESET}
echo -e "${GREEN}                                          %%%#########**++==--:::${BLUE}.............................${RESET}${GREEN}::::-==++***#########%%%"${RESET}
echo -e "${GREEN}                                      %%%########*+==-::${BLUE}................................................${RESET}${GREEN}::-=+***#######%%%"
echo -e "${GREEN}                                  %%%######**+=--::${BLUE}..........................................................${RESET}${GREEN}::-=++***#####%%%"
echo -e "${GREEN}                            %%######*+=-::${BLUE}.............................................................................${RESET}${GREEN}:=+***####%%"
echo -e "${GREEN}                         %%######*+=-:${BLUE}....................................................................................${RESET}${GREEN}:-+**#####%%"
echo -e "${GREEN}                   %#####*+=::${BLUE}...................................${RED}::---==+++**####****++==---:::${RESET}${BLUE}...................................${RESET}${GREEN}:=+*#####%%"
echo -e "${GREEN}                 %#####*+-:${BLUE}...................................${RED}::---=++*#%@@@@@@@%#%%@@%%#*+==---::${RESET}${BLUE}...................................${RESET}${GREEN}-+*#####%%"
echo -e "${GREEN}               %%####*+-:${BLUE}...................................${RED}::-=+*###***%%%%%@@%#*#%%%%%%%%%#*+=---:${RESET}${BLUE}..................................${RESET}${GREEN}:-+*#####%"
echo -e "${GREEN}             %%#####+=:${BLUE}...................................${RED}::-=+*%%%#+-:-*%%%%@@%#*#@@@%%%%%%%%%#*=---:${RESET}${BLUE}..................................${RESET}${GREEN}:-+######%"
echo -e "${GREEN}           %%#####*=:${BLUE}...................................${RED}::-=+#####%%*=--*%###%@%#*#@@@@@@%%%%#####+=---:${RESET}${BLUE}..................................${RESET}${GREEN}:=*#####%%"
echo -e "${GREEN}          %#####*=:${BLUE}....................................${RED}:--+*%%#+==*##*++*####%@%##%@@@@@@%#+=---=***+=--:${RESET}${BLUE}...................................${RESET}${GREEN}-=*#####%%"
echo -e "${GREEN}        %%####*+-:${BLUE}....................................${RED}:-=*%%%%%#+==*###*+#%%%%@@%%@@@@@@#+-.....:-+###+--:${RESET}${BLUE}...................................${RESET}${GREEN}:-+*#####%"
echo -e "${GREEN}       %#####*=:${BLUE}.....................................${RED}:-=*%@@%##%#*=+++*##%%%%##%@@@@@@@#=:.......:=*%%#+--:${RESET}${BLUE}....................................${RESET}${GREEN}:=*#####%"
echo -e "${GREEN}      %####*+-:${BLUE}.....................................${RED}:-=#%@@@@%%####++=+#%@@%#+=*%@@%%%%*-:.......-+#%@@#+--:${RESET}${BLUE}....................................${RESET}${GREEN}:-+#####%%"
echo -e "${GREEN}     %####*+-${BLUE}......................................${RED}:-=*%@@%%%%%%%#%%#***#%@%*-:-*%%%%%%+-:.....:-*#%%@%%#=-::${RESET}${BLUE}....................................${RESET}${GREEN}:-+*#####%"
echo -e "${GREEN}   %%####*=:${BLUE}.......................................${RED}:-+#@@@%%%%%%%%%%%%%#*#%%#=-+#%%%%%#+=----=+*#%#*++*##+=-:${RESET}${BLUE}......................................${RESET}${GREEN}:=*#####%"
echo -e "${GREEN}  %%####*=:${BLUE}.......................................${RED}:-=*%@@%%#%%%@@%%%%%%%%##%%##%%%%%%%#*#####%%#+=---=*#%#+-::${RESET}${BLUE}......................................${RESET}${GREEN}:=*#####%"
echo -e "${GREEN} %%####*+:${BLUE}........................................${RED}:-+#%%#%%%%%%@@@%%%%%%%%%%%@@%%%%%%%#%%%##%%#***###%%%%#*=-:${RESET}${BLUE}.......................................${RESET}${GREEN}:=*#####%"
echo -e "${GREEN}%%####*=:${BLUE}.........................................${RED}:-+#%#**++***#%@%%%%%%%###%%%##%%%%%%%%%###%%#*+=---=+##*=-:${RESET}${BLUE}........................................${RESET}${GREEN}:+*#####%"
echo -e "${GREEN}%####*+:${BLUE}..........................................${RED}:-+#%##***####%@%%%%%%##%%%#######%%%%%%###%%*+=====+*#%#+-:${RESET}${BLUE}.........................................${RESET}${GREEN}:+*####%"
echo -e "${GREEN}%####*=:${BLUE}..........................................${RED}:=+#%#*+++++*#%@@%%%%%%%%@%########%#%%%%%#%%%@@@@@@@%@@#+-:${RESET}${BLUE}.........................................${RESET}${GREEN}:=*#####"
echo -e "${GREEN}%%###*+-${BLUE}..........................................${RED}:-+#%##******#%@@@%%%%##%@%%%###%%%###%%%%%%%%#*****##%%#+-:${RESET}${BLUE}.........................................${RESET}${GREEN}-+*####%"
echo -e "${GREEN} %%###*+-${BLUE}.........................................${RED}:-+#%#*++**##%%@@@%%%%%#*%%@%%%%%%###%%%%%%%@%#*++**##%%*=-:${RESET}${BLUE}........................................${RESET}${GREEN}-+*####%"
echo -e "${GREEN}  %%###*+-${BLUE}........................................${RED}:-=#@@@%%%%%#*#%@@@%%%%%###########%%%%%%%@@%@@@%%%##%%#+-::${RESET}${BLUE}.......................................${RESET}${GREEN}:+*####%"
echo -e "${GREEN}   %%####+-:${BLUE}.......................................${RED}:-+%@%#*****###%@@@%%%%%%%%#####%%%%%%%%@@%#****##%%@%*=-:${RESET}${BLUE}......................................${RESET}${GREEN}:-+*####%"
echo -e "${GREEN}    %%####+-:${BLUE}......................................${RED}:-=*%%***##***#%@@@@@@%%%%%%%%%%%%%%%%%%%##%#*+**##%%#+-::${RESET}${BLUE}.....................................${RESET}${GREEN}:-*#####%"
echo -e "${GREEN}     %%####*=:${BLUE}......................................${RED}:-+#%%#*++*#%@%%%%@@@@%%%%%%%%%%%%%%%##***++**###%@%+=-:${RESET}${BLUE}.....................................${RESET}${GREEN}:=*####%%"
echo -e "${GREEN}       %####*=:${BLUE}......................................${RED}:-+#%###%%%%%#**#%@@@@@@@@@@@@@@%%#*+=++++=++*#%%%*=-:${RESET}${BLUE}.....................................${RESET}${GREEN}:=*####%%"
echo -e "${GREEN}        %####*+-:${BLUE}.....................................${RED}:-=#%@@@%%#*++#%%%%%%@%###%%###+==+++====++*#%%#+--:${RESET}${BLUE}....................................${RESET}${GREEN}:-+*####%"
echo -e "${GREEN}         %%####*=:${BLUE}.....................................${RED}:-=*%@@%#+=+**#%%##%@%+=+**=-+=--=***+=+**#%%#+-::${RESET}${BLUE}....................................${RESET}${GREEN}:=*####%%"
echo -e "${GREEN}           %####*+-:${BLUE}.....................................${RED}:-+#%%#***==*%#*#@@%*=+#*=-=++==*##**##%%#*=-:${RESET}${BLUE}....................................${RESET}${GREEN}:-+*####%"
echo -e "${GREEN}            %%####*=:${BLUE}.....................................${RED}::=+#%%%**#%#**%@@%*+*##*++*****#%@%%%#*=--:${RESET}${BLUE}...................................${RESET}${GREEN}:-+*####%%"
echo -e "${GREEN}              %%###**=:${BLUE}.....................................${RED}::-+*#%%@%###@@@@#*#%%#**#%%%%%%%%#+=-::${RESET}${BLUE}...................................${RESET}${GREEN}:-=*####%%"
echo -e "${GREEN}                %%###*+=:${BLUE}......................................${RED}:--+*##%%@@@@@%%%@@%%%%%%%%#*+=--::${RESET}${BLUE}...................................${RESET}${GREEN}:-=+*####%"
echo -e "${GREEN}                  %%###**=:${BLUE}.......................................${RED}:--==+*##%%%%%%%%###*++=--::${RESET}${BLUE}......................................${RESET}${GREEN}:=**####%%"
echo -e "${GREEN}                    %%####*=-:${BLUE}........................................${RED}::----=======----:::${RESET}${BLUE}......................................${RESET}${GREEN}::-+*#####%%"
echo -e "${GREEN}                      %%###**+=:${BLUE}..............................................................................................${RESET}${GREEN}:-=**####%%"
echo -e "${GREEN}                         %%###**+=:${BLUE}........................................................................................${RESET}${GREEN}:-=+*#####%%"
echo -e "${GREEN}                          %%####**+-:${BLUE}.................................................................................${RESET}${GREEN}::-=+*#####%%"
echo -e "${GREEN}                             %%####**+=-:${BLUE}..........................................................................${RESET}${GREEN}::-+**#####%%"
echo -e "${GREEN}                                 %%####***+=-:${BLUE}..................................................................${RESET}${GREEN}::-=+*#####%%%"
echo -e "${GREEN}                                    %%####***+=-::${BLUE}.......................................................${RESET}${GREEN}:::-==+**#####%%%"
echo -e "${GREEN}                                        %%######**++=-:::${BLUE}..........................................${RESET}${GREEN}:::-=++**#######%%%"
echo -e "${GREEN}                                            %%%#######****++==--::::::::::::::::::::::::::::-===++*****#######%%%"${RESET}
echo -e "${GREEN}                                                   %%%##########******************+++++++*****##########%%%%"${RESET}
echo -e "${GREEN}                                                         %%%%%################################%%%%%"${RESET}
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
echo ""
echo -e "Currently logged in as: ${GREEN}$userroot${RESET}" 
echo ""
echo
echo "What would you like to do?"
    echo "1) Goto shell for debugging"
    echo -e "2) Login as ${RED}$userrootopposite${RESET}"
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
        Echo "entering locked down mode"
        ;;
        *)
            read -ep "Invalid option, press enter to return :P"			
            ;;
    esac
    fi     
    done
