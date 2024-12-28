#ifndef TPM_H
#define TPM_H
#include <stddef.h>

int tpm_nvwrite(char* index, char* bytes);
int tpm_nvread(char* index, char* size);

#endif