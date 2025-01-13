#!/bin/bash

if pgrep -x "picom" > /dev/null
then
    echo "El proceso 'picom' está corriendo. Ejecutando 'killall picom'."
    killall picom
else
    echo "El proceso 'picom' no está corriendo. Ejecutando 'picom &'."
    picom &
fi

