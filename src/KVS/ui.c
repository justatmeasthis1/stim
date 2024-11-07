#include <stdio.h>

void ui_flash(char* flashtype) {
	printf("wip\n");
}

void ui_header(char* fwver, char* kernver, char* tpmver, char* fwmp, char* gscver, char* gsctype){
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