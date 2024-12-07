#ifndef TPM_H
#define TPM_H
#include <stddef.h>

int tpm_nvwrite(char* index, char* bytes, char* offset, char* authType, char* indexPassword);
int tpm_nvread(char* index, char* size, char* offset, char* authType, char* indexPassword);

#endif