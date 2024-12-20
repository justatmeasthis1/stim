# Using KVG (Kernel Version Generator)
Using KVG is very simple, all you need to know is if your device has v0 or v1.

This can be figured out very easily, if your device is oldui (white mode) recovery, then its v0,

if your device is newui (dark mode) recovery, then its v1.<br><br>

CLI Args:
```
$ ./kvg
USAGE: ./kvg <kernver> <optional flags>
e.g.: ./kvg 0x00010001 --raw --ver=0
--raw - prints the output as raw hex bytes
--ver=<0/1> - specifies the kernver struct version to use
--help - shows this message :3
KVG was created by kxtzownsu
(now written in Rust)
$
```

To use V0 recovery, pass `--ver=0` onto the END of the command, after putting the binary,

pass your flags, like this:

`./kvg 0x00010001 --ver=0 --raw`

NOT like this:

`./kvg --raw --ver=0 0x00010001`

Passing `--raw` will give you the raw hex output, instead of it printing like this `02 4c` it would print `\x2\x4c`.

# Using KVS (Kernel Version Switcher)
One thing to note, if you aren't using cr50-hammer or RMASmoke, then you must be **UNENROLLED**!

If you *are* using RMASmoke, make sure you're on Cr50 RW Version 0.5.229 or lower.

If you *are* using cr50-hammer, make sure <fill in later when cr50-hammer patch>.

If you *aren't* using RMASmoke or cr50-hammer, make sure to use the `tpm0 flash` method!

## Examples:
***Flashing via tpm0 flash***
```
KVS: Kernel Version Switcher (codename Maglev, bid: 2.0.0))
FW Version: Google_Grunt.11031.149.0
Kernel Version: 0x00010001
TPM: 2.0
FWMP: 0x1
GSC RW Version: 0.5.229
GSC Type: Cr50
-=-=-=-=-=-=-=-=-=-=-=-=-
1) Flash new kernver via /dev/tpm0 (REQ. UNENROLLED)
2) Flash new kernver via RMASmoke (REQ. CR50 VER 0.5.229 OR LOWER)
3) Make kernver index unwritable
4) Shell
5) Reboot
> 1
What kernver would you like to flash?
> 0x00010001
Does your device have lightmode (v0) or darkmode (v1) recovery? Please type either v0 or v1.
> v0
writing 13 bytes...
Finished! Press ENTER to return to main menu
```

<finish docs when RMASmoke & cr50-hammer release>
