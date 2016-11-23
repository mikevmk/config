#!/bin/sh

# docker-scripts: xdg-open support
# 2016 Mike Kuznetsov <mike4gg@gmail.com>

uid=`id -u`
tmpfile=`mktemp /run/user/$uid/xdg-open-docker/XXXXXXXXXXX`
echo "$@" > $tmpfile
