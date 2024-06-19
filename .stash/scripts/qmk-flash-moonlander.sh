#!/bin/sh
cp -rf ~/.config/kbd/moonlander/* ~/qmk_firmware/keyboards/moonlander/keymaps/ellis/
qmk flash -kb moonlander -km ellis
