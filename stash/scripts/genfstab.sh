#!/bin/sh
if [$# -eq 0] then genfstab -U -L -p / | less
else genfstab -U -L -p / | $1
