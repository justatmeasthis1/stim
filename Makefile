CC ?= gcc
SHELL ?= /bin/sh
KVSFLIST := \
	src/KVS/main.c \
	src/KVS/tpm.c \
	src/KVS/rmasmoke.c \
	src/KVS/ui.c 

CFLAGS := \
	-Iinclude \
	-g \
	-O3 \
	-Llib \
	-static

all: clean build kvs kvg

kvs: build/bin/kvs
kvg: build/bin/kvg

build:
	$(shell mkdir -p build/bin)

build/bin/kvs: src/KVS/main.c
	$(CC) $(KVSFLIST) -o build/bin/kvs $(CFLAGS)
	chmod +rx build/bin/kvs

build/bin/kvg: src/KVG/main.c
	$(CC) src/KVG/main.c -o build/bin/kvg $(CFLAGS)
	chmod +rx build/bin/kvg

install:
	cp -r build/* /usr/local/

clean:
	rm -rf build
