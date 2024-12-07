#ifndef SYSINFO_H
#define SYSINFO_H

#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>

#include "tpm.h"

void trim_newline(char* str) {
    size_t len = strlen(str);
    if (len > 0 && str[len - 1] == '\n') {
        str[len - 1] = '\0';
    }
}


const char* getFirmwareVersion(){
    // note, may not work on all chromebooks
    FILE *fptr;
    char stupidfile[] = "/sys/class/dmi/id/bios_version";
    fptr = fopen(stupidfile, "r");
    static char firmwareVersion[1024];

    if (fptr == NULL) {
        printf("Error reading Firmware Version \n");
        printf("Please report as a bug at https://github.com/kxtzownsu/KVS-private\n");

        sleep(86400); // sleep for 1d if error
        return "Error!"; 
    }
    fgets(firmwareVersion, 100, fptr); 
    fclose(fptr);

    trim_newline(firmwareVersion);

    return firmwareVersion;
}

// uint32_t getKernelVersion(){
// }

// this is kinda shitty, but until the TPM2 API is done, this is how we have to do it
const char* getTpmVersion(){
    char cmd[] = "tpmc tpmver";
    static char output[5];

    FILE* fp = popen(cmd, "r");
    fgets(output, sizeof(output), fp);
	fclose(fp);

    trim_newline(output);

    return output;
}


#endif