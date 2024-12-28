#include <stdio.h>
#include <stdlib.h>

// yeah kill me but this is just a `tpmc` wrapper :troll: 

/* ARGS:
index = that what TPM2 index to read from, e.g: "0x1008"
size = how many bytes should we read
*/
int tpm_nvwrite(char* index, char* bytes){
    printf ("wip, index: %s, bytes: '%s'", index, bytes);
    return 0;
}


/* ARGS:
index = that what TPM2 index to read from, e.g: "0x1008"
size = how many bytes should we read
*/
int tpm_nvread(char* index, char* size){
    printf ("wip, index: %s, size: '%s'", index, size);
    return 0;
}