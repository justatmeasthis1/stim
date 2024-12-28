# Cross-compiling the KVS project
To cross-compile the KVS project, all you need to do is set `$ARCH` to a correct architecture, <br>
and also install the cross-compilation libraries for your target arch.

Heres an example:

`ARCH=aarch64 make all`

All architectures:

`x86_64, armv7, aarch64`