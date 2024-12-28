#ifndef SYSINFO_H
#define SYSINFO_H

#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>

#include "tpm.h"    
#include "kernver.h"
#include "hex_utils.h"

const char *KERNVER_TYPE = "N/A. This is an error, please report at https://github.com/kxtzownsu/KVS with a picture of the screen.";

void trim_newline(char* str) {
    size_t len = strlen(str);
    if (len > 0 && str[len - 1] == '\n') {
        str[len - 1] = '\0';
    }
}


const char* getFirmwareVersion(){
    // note, may not work on all chromebooks
    // I also don't wanna have to rely on the crossystem binary for it
    FILE *fptr;
    char stupidfile[] = "/sys/class/dmi/id/bios_version";
    fptr = fopen(stupidfile, "r");
    static char firmwareVersion[1024];

    if (fptr == NULL) {
        printf("Error reading Firmware Version \n");
        printf("Please report as a bug at https://github.com/kxtzownsu/KVS-private\n");

        sleep(86400);
        return "Error!"; 
    }
    fgets(firmwareVersion, 100, fptr); 
    fclose(fptr);

    trim_newline(firmwareVersion);

    return firmwareVersion;
}

const char* getTpmVersion(){
    char cmd[] = "tpmc tpmver";
    static char output[5];

    FILE* fp = popen(cmd, "r");
    fgets(output, sizeof(output), fp);
	fclose(fp);

    trim_newline(output);

    return output;
}

const char* getKernver() {
    char cmd[] = "tpmc read 0x1008 9 2>";
    static char output[26];
    FILE* fp = popen(cmd, "r");
    fgets(output, sizeof(output), fp);
	fclose(fp);
    trim_newline(output);
    
    uint32_t kernver = 0;
    static char kernver_str[18] = "0x00000000";

    // ewwww yucky i hate this

    if (strncmp(output, "10", 2) == 0) {
        printf("using v1.0\n");
        unsigned int b1, b2, b3, b4;
        sscanf(output + 12, "%2x %2x %2x %2x", &b1, &b2, &b3, &b4);
        kernver = b1 | (b2 << 8) | (b3 << 16) | (b4 << 24);
        snprintf(kernver_str, sizeof(kernver_str), "0x%08x (v1.0)", kernver);
        KERNVER_TYPE = "v1";
    } else if (strncmp(output, "2", 1) == 0) {
        unsigned int b1, b2, b3, b4;
        sscanf(output + 14, "%2x %2x %2x %2x", &b1, &b2, &b3, &b4);
        kernver = b1 | (b2 << 8) | (b3 << 16) | (b4 << 24);
        snprintf(kernver_str, sizeof(kernver_str), "0x%08x (v0.2)", kernver);
        KERNVER_TYPE = "v0";
    }


    return kernver_str;
}

const char* getFWMPFlags(){
    // char cmd[] = "tpmc read 0x100A 5 2>/dev/null";
    // static char output[256];
    // FILE* fp = popen(cmd, "r");
    // fgets(output, sizeof(output), fp);
    // fclose(fp);
    // trim_newline(output);
    static char output[256];
    output = ""'


    if (strcmp(output, "") == 0) {
        return "N/A (Most likely unenrolled)";
    } else {
        uint8_t flags = 0;
        static char flags_str[4];
        unsigned int b1;
        sscanf(output + 12, "%2x", &b1);
        flags = b1;
        snprintf(flags_str, sizeof(flags_str), "0x%08x (v1.0)", flags);
        return flags_str;
    }
}

const char* getGSCRWVersion(){
    char cmd[] = "gsctool -a -f | tail -n 1 | awk '{printf $2}'";
    static char output[8];
    FILE* fp = popen(cmd, "r");
    fgets(output, sizeof(output), fp);
	fclose(fp);
    trim_newline(output);

    return output;
}

const char* getGSCType(){
    char cmd[] = "/opt/kvs/bin/is_ti50";
    static char output[7];
    FILE* fp = popen(cmd, "r");
    fgets(output, sizeof(output), fp);
	fclose(fp);
    trim_newline(output);

    return output;
}

#endif