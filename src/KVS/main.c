#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ui.h"

int main(int argc, char **argv) {
	// example values for testing
	char* fwver = "Google_Grunt.11031.149.0";
	char* kernver = "0x00010001";
	char* tpmver = "2.0";
	char* fwmp = "0x1";
	char* gscver = "0.5.229";
	char* gsctype = "Cr50";

	// only allow 2 characters (option & newline)
	char choice[2];

	ui_header(fwver, kernver, tpmver, fwmp, gscver, gsctype);
	printf("1) Flash new kernver via /dev/tpm0 (REQ. UNENROLLED)\n");
	printf("2) Flash new kernver via RMASmoke (REQ. CR50 VER 0.5.229 OR LOWER)\n");
	printf("3) Make kernver index unwritable\n");
	printf("4) Shell\n");
	printf("5) Reboot\n");
	printf("> ");
	fgets(choice, sizeof(choice), stdin);
	if (choice[strlen(choice) - 1] == '\n') {
		choice[strlen(choice) - 1] = '\0';
	}
	printf("You entered: %s\n", choice);

	if (strcmp(choice, "1") == 0) {
		ui_flash("tpm0");
	}

	return 0;
}
