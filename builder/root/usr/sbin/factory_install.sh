#!/bin/bash

SCRIPT_DATE="[dec 15 2025]"
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
userroot=Guest
userrootopposite=Admin
goon=$gsdfjdfjh$afdhkl$ffdgjfdgf$ffhdsas$ffhdsas$nvgfgrtycea$ffhdsas$jkfdfdh$seuiweaewiy$jkfdfdh
clear
echo " ░▒▓███████▓▒░▒▓████████▓▒░▒▓█▓▒░▒▓██████████████▓▒░ "
echo "░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo "░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo " ░▒▓██████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo "       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo "       ░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "
echo "░▒▓███████▓▒░   ░▒▓█▓▒░   ░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓█▓▒░ "

echo "Currently logged in as: $userroot" 

echo "What would you like to do?"
    echo "1) Goto FMN"
    echo "2) Login as $userrootopposite (grants bash as well as cool unenrollment stuff)"
    echo "3) Creds :)"
    read -p "Choose option: " userchoice

    case $userchoice in
        1)
    echo "Heading to FMN, please wait..."
    sudo bash /usr/sbin/FMN.sh
    ;;
        2)
		echo "If you went here by mistake, type 1 to head to FMN"
    read -p "Login: " userpass
        ;;
    case $userpass in
        1)
        echo "heading to FMN, please wait..."
        sleep 3
        sudo bash /usr/sbin/FMN.sh
        ;;
        
        $goon)
        userroot=Admin
        userrootopposite=Guest
		echo "continuing on, fyi $userroot , $userrootopposite"
        bash
            ;;
        *)
            echo "hey twin, i wanna remind you something, this script has arbituary root code access, meaning i could literally brick your chromebook or get you suspended cause ur running this, but ill be nice and just reboot ya :P"
			sleep 10
            reboot -f
            
            ;;
            esac
        *)
            echo "Invalid option, taking you to FMN anyways..."
			sleep 3
			sudo bash /payloads/FMN.sh
            ;;
    esac
