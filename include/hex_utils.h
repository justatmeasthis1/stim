#ifndef HEX_UTILS_H
#define HEX_UTILS_H

#include <stdbool.h>
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

uint32_t convert_to_uint32(const char *str);
bool is_valid_hex(const char *str);
void print_hex(const uint8_t *data, uint32_t size);
bool grep(char *string, const char *pattern);

#endif // HEX_UTILS_H
