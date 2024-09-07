#include <stdio.h>
#include <stddef.h>
#include <stdint.h> 
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <limits.h>

#include "arg_checks.h"
#include "hex_utils.h"


// basically almost all of this code was pieced together
// using vboot_reference code, credits to Google
// for writing most of this code in a sense :3

struct vb2_secdata_kernel_v0 {
    uint8_t struct_version;  
    uint32_t uid;
    uint32_t kernel_versions;
    uint8_t reserved[3];
    uint8_t crc8;
} __attribute__((packed));

struct vb2_context {
    void *secdata_kernel;
};

uint8_t vb2_crc8(const void *vptr, uint32_t size)
{
    const uint8_t *data = vptr;
    unsigned crc = 0;
    uint32_t i, j;

    for (j = size; j; j--, data++) {
        crc ^= (*data << 8);
        for(i = 8; i; i--) {
            if (crc & 0x8000)
                crc ^= (0x1070 << 3);
            crc <<= 1;
        }
    }

    return (uint8_t)(crc >> 8);
}

static uint8_t secdata_kernel_crc(struct vb2_context *ctx)
{
    size_t offset, size;
    offset = 0;
    size = offsetof(struct vb2_secdata_kernel_v0, crc8);
    return vb2_crc8(ctx->secdata_kernel + offset, size);
}

int main(int argc, char *argv[]) {
    gargc = argc;
	gargv = argv;

    // if --help or no args are passsed
    // print the usage and an example command
    if (fbool("--help") || argc == 1){
        printf("USAGE: %s <kernver> <optl. flags>\n", argv[0]);
        printf("e.g: %s 0x00010001 --raw\n", argv[0]);
        printf("-=-=-=-=-=-=-\n");
        printf("--raw - prints the output as raw hex bytes\n");
        printf("--help - shows this message :3\n");
        printf("-=-=-=-=-=-=-\n");
        printf("KVG was created by kxtzownsu\n");
        exit(0);
    }

    struct vb2_secdata_kernel_v0 secdata;

    secdata.struct_version = 0x02;
    secdata.uid = 0x4752574c;
    secdata.reserved[0] = 0x00;
    secdata.reserved[1] = 0x00;
    secdata.reserved[2] = 0x00;

    // make sure the user sends us a correct hex value, 
    // we dont want to just blindly trust that its correct
    if (is_valid_hex(argv[1])) {
        uint32_t kvarg = convert_to_uint32(argv[1]);
        secdata.kernel_versions = kvarg;
    } else {
        printf("The entered kernver: %s, wasn't detected as valid hexadecimal, please try again.\n", argv[1]);
        exit(1);
    }

    struct vb2_context ctx;
    ctx.secdata_kernel = (void *)&secdata;

    secdata.crc8 = secdata_kernel_crc(&ctx);
    if (fbool("--raw")) {
        fwrite(&secdata, sizeof(secdata), 1, stdout);
    } else {
        print_hex((uint8_t *)&secdata, sizeof(struct vb2_secdata_kernel_v0));
    }
    return 0;
}