#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdbool.h>
#include <errno.h>
#include <endian.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <linux/types.h>

static inline int MIN(int a, int b) { return a < b ? a : b; }
#define EXTENSION_FW_UPGRADE 4
#define LAST_EXTENSION_COMMAND 15
#define CONFIG_EXTENSION_COMMAND 0xbaccd00a
#define TPM_CC_VENDOR_BIT_MASK 0x20000000
#define SIGNED_TRANSFER_SIZE 1024
#define MAX_RX_BUF_SIZE 2048
#define MAX_TX_BUF_SIZE (SIGNED_TRANSFER_SIZE + sizeof(struct tpm_pkt))
#define VENDOR_RC_ERR 0x500

#define VENDOR_RC_NO_SUCH_COMMAND 127
#define VENDOR_CC_GET_TI50_STATS 65
// TPM_RC == uint32_t
constexpr uint32_t TPM_RC_BAD_TAG = 0x01E;

int tpm;

struct tpm_pkt {
    __be16 tag;
    __be32 length;
    __be32 ordinal;
    __be16 subcmd;
    union {
        struct {
            __be32 digest;
            __be32 address;
            char data[0];
        } upgrade;
        struct {
            char data[0];
        } command;
    };
} __attribute__((packed));


static int send_payload(unsigned int digest, unsigned int addr, 
                        const void *data, int size, uint16_t subcmd)
{
	static uint8_t outbuf[MAX_TX_BUF_SIZE];
	struct tpm_pkt *out = (struct tpm_pkt *)outbuf;
	int len, done;
	void *payload;
	size_t header_size;
	
	out->tag = htobe16(0x8001);
	out->subcmd = htobe16(subcmd);

	out->ordinal = htobe32((subcmd <= LAST_EXTENSION_COMMAND) ? CONFIG_EXTENSION_COMMAND : TPM_CC_VENDOR_BIT_MASK);
	
	if (subcmd == EXTENSION_FW_UPGRADE) {
		out->upgrade.digest = digest;
		out->upgrade.address = htobe32(addr);
		header_size = offsetof(struct tpm_pkt, upgrade.data);
	}else{
		header_size = offsetof(struct tpm_pkt, command.data);
	}

	payload = outbuf + header_size;
	len = size + header_size;

	out->length = htobe32(len);
	memcpy(payload, data, size);

	done = write(tpm, out, len);

	if (done < 0) {
		fprintf(stderr, "Error: Failed to write to TPM, %s.\n", strerror(errno));
		return -1;
	}else if (done != len) {
		fprintf(stderr, "Error: Expected to write %d bytes to TPM, instead wrote %d. %s\n", len, done, strerror(errno));
		return -1;
	}

	return 0;
}

static int read_response(void *response, size_t *response_size)
{
    static uint8_t raw_response[MAX_RX_BUF_SIZE + sizeof(struct tpm_pkt)];
    int response_offset = offsetof(struct tpm_pkt, command.data);
    const size_t rx_size = sizeof(raw_response);
	uint32_t rv;

    int read_count, len;

	len = 0;
	do {
		uint8_t *rx_buf = raw_response + len;
		size_t rx_to_go = rx_size - len;

		read_count = read(tpm, rx_buf, rx_to_go);

		len += read_count;
	} while (read_count);

    len = len - response_offset;
	if (len < 0) {
		fprintf(stderr, "Error: Problems reading from TPM, got %d bytes.\n", len + response_offset);
		return -1;
	}

	len = MIN(len, *response_size);
	memcpy(response, raw_response + response_offset, len);
	*response_size = len;

	memcpy(&rv, &((struct tpm_pkt *)raw_response)->ordinal, sizeof(rv));
	rv = be32toh(rv);

	if ((rv & VENDOR_RC_ERR) == VENDOR_RC_ERR) rv &= ~VENDOR_RC_ERR;

	return rv;
}

bool is_ti50(int *rc)
{
    uint8_t resp;
    size_t response_size = sizeof(resp);

    tpm = open("/dev/tpm0", O_RDWR);
    if (tpm < 0) {
        fprintf(stderr, "Error: Cannot open TPM device: %s\n", strerror(errno));
		*rc = -1;
        return false;
    }

    if (send_payload(0, 0, NULL, 0, VENDOR_CC_GET_TI50_STATS) != 0) {
        fprintf(stderr, "Error: Failed to send GET_TI50_STATS to TPM.\n");
        close(tpm);
        *rc = -1;
		return false;
    }

    int rv = read_response(&resp, &response_size);
    close(tpm);

    *rc = rv;

    if (rv == TPM_RC_BAD_TAG)     				 // TPM 1.2
        return false;
    else if (rv == VENDOR_RC_NO_SUCH_COMMAND) 	 // Cr50
        return false;
    else 										 // valid Ti50 response
        return true;
}

int main() {
    int rc;

    bool ti50 = is_ti50(&rc);

    if (rc == TPM_RC_BAD_TAG) {
        printf("TPM 1.2\n");
    } else if (rc == VENDOR_RC_NO_SUCH_COMMAND) {
        printf("Cr50\n");
    } else if (rc > 0) {
        printf("Ti50\n");
    } else {
		printf("Unknown\n");
	}

    return rc;
}