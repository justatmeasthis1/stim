#!/bin/bash
SHIMDIR="$1"

error(){
	echo $@
	exit 1
}

[ "$EUID" -ne 0 ] && error "Please run as root"

if [[ "$SHIMDIR" == "" ]]; then
	error "no shimdir specified"
fi

if [[ -z "$SHIMDIR" ]]; then
	error "$SHIMDIR is empty, not using."
fi

echo "building shims in $SHIMDIR"
files=$(find "$SHIMDIR" -name "*.bin" | sort)

for file in $files; do
	echo "building $file"
	export AUTOBUILD=1 # this is actually a KVS builder thing, for other shim builders you should be able to remove it
	bash builder.sh $file
done
