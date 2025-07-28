#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "ui.h"
#include "sysinfo.h"
#include "arg_checks.h"

void kernver_faq() {
    printf(
        "--------- KV Compatibility list ---------\n"
        "Last Updated: 2025-07-28 12:40 PM ET\n"
        "-----------------------------------------\n"
        "Kernver 0:  Boots all versions\n"
        "Kernver 1:  Boots all versions\n"
        "Kernver 2:  Boots R112 and up\n"
        "Kernver 3:  Boots R120 and up\n"
        "Kernver 4:  Boots R125 and up\n"
        "Kernver 5:  Boots R133* and up\n"
        "-----------------------------------------\n"
        "* Note: Some late R132 builds are Kernver 5, but hard to find.\n"
    );
}


void dbgprintf(char* text){
	if (fbool("--debug","-d")){
		printf("DEBUG: %s\n", text);
	}
}

int main(int argc, char **argv) {
	gargc = argc;
	gargv = argv;
	if (geteuid() !=  0){
		printf("Please run KVS as root!\n");
		printf("This is a bug, please report it at https://github.com/kxtzownsu/KVS");
		sleep(86400);
	}

	// const char* fwver = getFirmwareVersion();
	const char* tpmver = getTpmVersion();
	const char* fwmp = getFWMPFlags();
	const char* gscver = getGSCRWVersion();
	const char* gsctype = getGSCType();
	

	// only allow 2 characters (option & newline)
	char choice[3];
	dbgprintf("ui loop \n");
	while (true) {
		char* kernver = getKernver();
		
		printf("\033[H\033[J"); // clears the screen

		ui_header(kernver, tpmver, fwmp, gscver, gsctype);
		printf("1) Flash new kernver \n");
		printf("2) Run KAUB (Kernver Automatic Update Blocker) \n");
		printf("3) Kernver FAQ \n");
		printf("4) Credits\n");
		printf("5) Shell\n");
		printf("6) Reboot\n");
		printf("> ");
		fgets(choice, sizeof(choice), stdin);
		if (choice[strlen(choice) - 1] == '\n') {
        	choice[strlen(choice) - 1] = '\0';
    	}

		if (!strcmp(choice, "1")) {
			ui_flash("tpm0");
			enterToContinue();
		} else if (!strcmp(choice, "2")) {
			printf("KAUB is not avaliable on v2.0.0. Please either update your shim or wait for KAUB to release on v2.1\n");
			enterToContinue();
		} else if (!strcmp(choice, "3")) {
			kernver_faq();
			enterToContinue();
		} else if (!strcmp(choice, "4")) {
			show_credits();
			enterToContinue();
		} else if (!strcmp(choice, "5")) {
			system("/bin/bash");
			enterToContinue();
		} else if (!strcmp(choice, "6")) {
			exit(1);
		} else if (!strcmp(choice, "7")) {
			troll();
		} else {
			printf("You have entered an invalid option... how?? Next time, only input the number.\n");
			printf("Example: > 1\n");
			enterToContinue();
		}
	}

	return 0;
}
