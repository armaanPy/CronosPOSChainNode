#!/bin/bash
# Script which is used to determine the upgrade height of 922,363, at which users will see the following error message on the chain-maind: ERR UPGRADE "v2.0.0" NEEDED

LOG=~/node.log
ERROR='ERR UPGRADE "v2.0.0" NEEDED'

while true; do
        if grep -q "$ERROR" "$LOG"; then
                exit
        else
                sleep 60
                continue
        fi
        break
done
