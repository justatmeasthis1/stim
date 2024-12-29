#!/bin/bash

setterm -cursor on

chmod +rx /bin/kvs 
chmod +rx /bin/kvg

/bin/kvs

reboot now
sleep 1d