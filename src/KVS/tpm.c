#include <stdio.h>


/* ARGS:
index = that what TPM2 index to read from, e.g: "0x1008"
size = how many bytes should we read
offset = how far into the index should we start reading
authType = either owner, index, or platform
indexPassword = if index authType is chosen, enter your indexPassword, otherwise pass nothing
*/
int tpm_nvwrite(char* index, char* bytes, char* offset, char* authType, char* indexPassword){
    printf ("wip, index: %s, bytes: '%s', offset: %s, authType: %s, indexPassword: %s", index, bytes, offset, authType, indexPassword);
    return 0;
}


/* ARGS:
index = that what TPM2 index to read from, e.g: "0x1008"
size = how many bytes should we read
offset = how far into the index should we start reading
authType = either owner, index, or platform
indexPassword = if index authType is chosen, enter your indexPassword, otherwise pass nothing
*/
int tpm_nvread(char* index, char* size, char* offset, char* authType, char* indexPassword){
    printf ("wip, index: %s, size: '%s', offset: %s, authType: %s, indexPassword: %s", index, size, offset, authType, indexPassword);
}