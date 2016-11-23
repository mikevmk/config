#!/bin/sh

skypeforlinux

while [ 1 ]; do
    if [ `pgrep skypeforlinux | wc -l` -eq 0 ]; then break; fi
    sleep 5
done
