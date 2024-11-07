#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: ./compiler.sh <name>"
    exit 1
fi

TB_FILE="$1"

for FILE in *.vhd; do
    FILE_NAME="${FILE%.vhd}"
    
    ghdl -a "$FILE"
    ghdl -e "$FILE_NAME"

    if [ -f "${FILE_NAME}_tb.vhd" ]; then
        ghdl -a "${FILE_NAME}_tb.vhd"
        ghdl -e "${FILE_NAME}_tb"
    fi
done

ghdl -r "${TB_FILE}_tb" --wave="${TB_FILE}_tb.ghw"

gtkwave "${TB_FILE}_tb.ghw"
