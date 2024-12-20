CC ?= gcc
ARCH ?= x86_64
TOOLCHAIN ?= musl
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

ifeq ($(ARCH), aarch64)
CC := aarch64-linux-gnu-gcc
endif

ifeq ($(ARCH), armv7)
CC := armv7-linux-gnu-gcc
TOOLCHAIN := musleabihf
endif

TARGET = ${ARCH}-unknown-linux-${TOOLCHAIN}

all: clean build kvs kvg

kvs: build build/bin/kvs
kvg: build build/bin/kvg
kvg-c: build build/bin/kvg-c

build:
	$(shell mkdir -p build/bin)

build/bin/kvs: src/KVS/main.c
	$(CC) $(KVSFLIST) -o build/bin/kvs $(CFLAGS)
	chmod +rx build/bin/kvs

build/bin/kvg: src/KVG/main.rs
	cargo build --bin KVG --target=$(TARGET) --release
	cp target/$(TARGET)/release/KVG build/bin/kvg

# The C version of KVS, not normally built.
# Also guaranteed to be out-of-date.
build/bin/kvg-c: src/KVG/main.c
	$(CC) src/KVG/main.c -o build/bin/kvg-c $(CFLAGS)
	chmod +rx build/bin/kvg-c

install:
	cp -r build/* /usr/local/

clean:
	rm -rf build
	rm -rf target
