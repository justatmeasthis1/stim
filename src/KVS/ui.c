#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>


#include "tpm.h"
#include "hex_utils.h"
#include "kernver.h"

void ui_flash(char* flashtype) {
	// i feel like this is some of the dirtiest C that
	// i've ever written, please ignore it
	#define V0_SIZE 38
	#define V1_SIZE 120

	char kvgout_v0[V0_SIZE + 1];
	char kvgout_v1[V1_SIZE + 1];

	char kerninput[12];

	printf("What kernver would you like to flash? \n");
	printf("> ");
	fgets(kerninput, sizeof(kerninput), stdin);
	// nya
	if (kerninput[strlen(kerninput) - 1] == '\n') {
        kerninput[strlen(kerninput) - 1] = '\0';
    }
	if (!is_valid_hex(kerninput)){
		fprintf(stderr, "Your kernver, %s, was an invalid input. Not hex.", kerninput);
		exit(1);
	}

	// the output of strcmp if it fails is True
	if (strcmp(KERNVER_TYPE, "v0") && strcmp(KERNVER_TYPE, "v1")){
		fprintf(stderr, KERNVER_TYPE);
		exit(1);
	}

	// we check if its *false* since strcmp returns true if failing
	if (!strcmp(KERNVER_TYPE, "v0")){ 
		char cmd[128];

		snprintf(cmd, sizeof(cmd), "kvg %s --ver=0", kerninput);
    	FILE* fp = popen(cmd, "r");
    	fgets(kvgout_v0, sizeof(kvgout_v0), fp);
		fclose(fp);
	} else if (!strcmp(KERNVER_TYPE, "v1")) {
		char cmd[128];

		snprintf(cmd, sizeof(cmd), "kvg %s --ver=1", kerninput);
    	FILE* fp = popen(cmd, "r");
    	fgets(kvgout_v1, sizeof(kvgout_v1), fp);
		fclose(fp);
	}
	

	if (flashtype == "tpm0"){
		if (!strcmp(KERNVER_TYPE, "v0")) {
			tpm_nvwrite("0x1008", kvgout_v0);

		} else if (!strcmp(KERNVER_TYPE, "v1")) {
			tpm_nvwrite("0x1008", kvgout_v1);
		}
	} else if (flashtype == "rmasmoke"){
		printf("using rmasmoke\n");
	}
}

void ui_header(const char* fwver, char* kernver, const char* tpmver, const char* fwmp, const char* gscver, const char* gsctype){
	printf("KVS: Kernel Version Switcher (codename Maglev, bid: 2.0.0)\n");
	printf("FW Version: %s\n", fwver);
	printf("Kernel Version: %s\n", kernver);
	printf("TPM: %s\n", tpmver);
	printf("FWMP: %s\n", fwmp);
	printf("GSC RW Version: %s\n", gscver);
	printf("GSC Type: %s\n", gsctype);
	printf("-=-=-=-=-=-=-=-=-=-=-=-=-\n");
}

void show_credits(){
	printf("kxtzownsu - Writing KVS 1 and 2\n");
	printf("Hannah/ZegLol - writing is_ti50, mental support, testing\n");
}

void troll(){
	while (true){
		printf("\033[H\033[J");
    	printf(
        	"         333333333333333   \n"
        	"        3:::::::::::::::33 \n"
        	"        3::::::33333::::::3\n"
        	"        3333333     3:::::3\n"
        	"                    3:::::3\n"
        	" ::::::             3:::::3\n"
        	" ::::::     33333333:::::3 \n"
        	" ::::::     3:::::::::::3  \n"
        	"            33333333:::::3 \n"
        	"                    3:::::3\n"
        	"                    3:::::3\n"
        	" ::::::             3:::::3\n"
        	" :::::: 3333333     3:::::3\n"
        	" :::::: 3::::::33333::::::3\n"
        	"        3:::::::::::::::33 \n"
        	"         333333333333333   \n"
    	);
		sleep(1);
	}
}

void enterToContinue() {
    printf("\nPress ENTER to return to the main menu\n");
    getchar();
}