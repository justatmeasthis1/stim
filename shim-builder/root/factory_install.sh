#!/bin/bash

setterm -cursor on

chmod +rx /bin/kvs 
chmod +rx /bin/kvg

rm -rf /etc/trunksd.conf
rm -rf /etc/tcsd.conf

/bin/kvs

reboot now
sleep 1d