#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>


#include "tpm.h"
#include "hex_utils.h"

void ui_flash(char* flashtype) {
	// i feel like this is some of the dirtiest C that
	// i've ever written, please ignore it
	#define V0_SIZE 38
	#define V1_SIZE 120

	char kvgout_v0[V0_SIZE + 1];
	char kvgout_v1[V1_SIZE + 1];

	char kerninput[12];
	char structtype[4];

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

	printf("Does your device have lightmode (v0) or darkmode (v1) recovery? Please type either v0 or v1.\n");
	printf("> ");
	fgets(structtype, sizeof(structtype), stdin);
	if (structtype[strlen(structtype) - 1] == '\n') {
        structtype[strlen(structtype) - 1] = '\0';
    }

	// the output of strcmp if it fails is True
	if (strcmp(structtype, "v0") && strcmp(structtype, "v1")){
		fprintf(stderr, "Invalid struct type %s, valid types are v0 and v1\n", structtype);
		exit(1);
	}

	// we check if its *false* since strcmp returns true if failing
	if (!strcmp(structtype, "v0")){ 
		char cmd[128];

		snprintf(cmd, sizeof(cmd), "kvg %s --ver=0", kerninput);
    	FILE* fp = popen(cmd, "r");
    	fgets(kvgout_v0, sizeof(kvgout_v0), fp);
		fclose(fp);
	} else if (!strcmp(structtype, "v1")) {
		char cmd[128];

		snprintf(cmd, sizeof(cmd), "kvg %s --ver=1", kerninput);
    	FILE* fp = popen(cmd, "r");
    	fgets(kvgout_v1, sizeof(kvgout_v1), fp);
		fclose(fp);
	}
	

	if (flashtype == "tpm0"){
		if (!strcmp(structtype, "v0")) {
			tpm_nvwrite("0x1008", kvgout_v0, "0", "platform", "");
		} else if (!strcmp(structtype, "v1")) {
			tpm_nvwrite("0x1008", kvgout_v1, "0", "platform", "");
		}
	} else if (flashtype == "rmasmoke"){
		printf("using rmasmoke\n");
	}
}

void ui_header(const char* fwver, char* kernver, const char* tpmver, char* fwmp, char* gscver, char* gsctype){
	printf("KVS: Kernel Version Switcher (codename Maglev, bid: 2.0.0))\n");
	printf("FW Version: %s\n", fwver);
	printf("Kernel Version: %s\n", kernver);
	printf("TPM: %s\n", tpmver);
	printf("FWMP: %s\n", fwmp);
	printf("GSC RW Version: %s\n", gscver);
	printf("GSC Type: %s\n", gsctype);
	printf("-=-=-=-=-=-=-=-=-=-=-=-=-\n");
}

void ui_credits(){
	printf("kxtzownsu - Writing KVS 1 and 2\n");
	printf("Hannah/ZegLol - Helping with /dev/tpm0 flashing, rewriting RMASmoke.\n");
	printf("Writable - Writing the RMASmoke vulnerability\n");
}