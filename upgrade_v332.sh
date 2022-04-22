#!/bin/bash
# Scipt which is used to determine the upgrade height of 3,526,800, at which users will see the following error message on the chain-maind: ERR UPGRADE "v3.0.0" NEEDED

LOG=~/node.log
ERROR='ERR UPGRADE "v3.0.0" NEEDED'

while true; do
        if grep -q "$ERROR" "$LOG"; then
                exit
        else
                sleep 60
                continue
        fi
        break
done
