#!/bin/bash
# 

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
