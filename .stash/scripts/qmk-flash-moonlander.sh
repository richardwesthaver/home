#!/bin/sh
cd ~/.stash/qmk_firmware
cp -rf ~/.config/kbd/moonlander/* keyboards/moonlander/keymaps/ellis/
qmk flash -kb moonlander -km ellis
