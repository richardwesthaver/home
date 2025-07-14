#!/bin/bash
if [ $# -ne 4 ]; then
   echo Usage: "$0" local other base output
   exit 1
fi
exec emacs --eval '(ediff-merge-with-ancestor "'"$1"'" "'"$2"'" "'"$3"'" nil "'"$4"'")'
