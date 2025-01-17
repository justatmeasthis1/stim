CC ?= gcc
ARCH ?= x86_64
TOOLCHAIN ?= musl
SHELL ?= /bin/sh
KVSFLIST := \
	src/KVS/main.c \
	src/KVS/tpm.c \
	src/KVS/rmasmoke.c \
	src/KVS/ui.c \
	src/KVS/hex_utils.c

TOOLS := \
	is_ti50

TOOL_SRC := \
	src/tools/is_ti50.c

TOOL_OBJS := $(patsubst src/tools/%.c,build/$(ARCH)/tools/%.o,$(TOOL_SRC))
TOOL_BINS := $(patsubst %,build/$(ARCH)/tools/%,$(TOOLS))

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
CC ?= armv7-linux-gnu-gcc
TOOLCHAIN := musleabihf
endif

TARGET = ${ARCH}-unknown-linux-${TOOLCHAIN}

all: clean build kvs kvg tools

kvs: build build/$(ARCH)/bin/kvs
kvg: build build/$(ARCH)/bin/kvg

.PHONY: build

tools: build $(TOOL_BINS)

build/$(ARCH)/tools/%: build/$(ARCH)/tools/%.o
	$(CC) $(LDFLAGS) -static -o $@ $<
	mv $@ build/$(ARCH)/bin/
	rm -rf build/$(ARCH)/tools

build/$(ARCH)/tools/%.o: src/tools/%.c
	$(CC) $(CFLAGS) -c -o $@ $<

build:
	mkdir -p build/$(ARCH)/bin
	mkdir -p build/$(ARCH)/tools

build/$(ARCH)/bin/kvs: src/KVS/main.c
	$(CC) $(KVSFLIST) -o build/$(ARCH)/bin/kvs $(CFLAGS)
	chmod +rx build/$(ARCH)/bin/kvs

build/$(ARCH)/bin/kvg: src/KVG/main.rs
	cargo build --bin KVG --target=$(TARGET) --release
	cp target/$(TARGET)/release/KVG build/$(ARCH)/bin/kvg
	chmod +rx build/$(ARCH)/bin/kvg

install:
	cp -r build/* /usr/local/

 clean:
    rm -rf build/$(ARCH)
    rm -rf target/$(TARGET)

deepclean:
        rm -rf build
        rm -rf target
