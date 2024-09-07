CC ?= gcc
SHELL ?= /bin/sh
KVSFLIST := \
	src/KVS/main.c \
	src/KVS/ui.c \
	src/KVS/kernver-utils.c

CFLAGS := \
	-Iinclude \
	-g \
	-static

$(shell mkdir -p build)

all: clean kvs kvg

kvs: build/kvs
kvg: build/kvg

build/kvs: src/KVS/main.c
	$(CC) $(KVSFLIST) -o build/kvs $(CFLAGS)
	chmod +rx build/kvs

build/kvg: src/KVG/main.c
	$(CC) src/KVG/main.c -o build/kvg $(CFLAGS)
	chmod +rx build/kvg

clean:
	rm -rf build