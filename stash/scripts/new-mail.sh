#!/bin/sh
attach_cmds=""
while [ $# -gt 0 ]; do
    fullpath=$(readlink --canonicalize "$1")
    attach_cmds="$attach_cmds (mml-attach-file \"$fullpath\")"
    shift
done
emacsclient -a '' -c -e "(progn (compose-mail) $attach_cmds)"
