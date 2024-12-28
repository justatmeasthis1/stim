#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "hex_utils.h"

int calculateByteSize(char* bytes){
    int byte_count = 0;
    char bytes_copy[256];
    strncpy(bytes_copy, bytes, sizeof(bytes_copy) - 1);
    bytes_copy[sizeof(bytes_copy) - 1] = '\0';

    char* token = strtok(bytes_copy, " ");
    while (token != NULL) {
        byte_count++;
        token = strtok(NULL, " "); 
    }
    return byte_count;
}



/* ARGS:
index = what TPM2 index to read from, e.g: "0x1008"
bytes = what bytes to write to `index`, e.g: "02 4c"

EXAMPLE:
tpm_nvwrite("0x1008", "02 4c");
  ⤷ returns int with amount of bytes written, e.g: "2"
*/
int tpm_nvwrite(char* index, char* bytes) {
    char cmd[2048];
    char output[1024];
    
    snprintf(cmd, sizeof(cmd), "tpmc write %s %s 2>/dev/null", index, bytes);
    FILE* fp = popen(cmd, "r");
    fgets(output, sizeof(output), fp);
    fclose(fp);

    return calculateByteSize(bytes);
}


/* ARGS:
index = what TPM2 index to read from, e.g: "0x1008"
size = how many bytes should we read, e.g: "2"

EXAMPLE:
tpm_nvread("0x1008", "2");
  ⤷ returns char with bytes read, e.g: "02 4c"
*/
char* tpm_nvread(char* index, char* size) {
    int intSize =  strtol(size, NULL, 10);
    char cmd[2048];
    static char output[1024];

    snprintf(cmd, sizeof(cmd), "tpmc read %s 0x%X", index, intSize);
    FILE* fp = popen(cmd, "r");
    fgets(output, sizeof(output), fp);
	fclose(fp);
    trim_newline(output);

    return output;
}