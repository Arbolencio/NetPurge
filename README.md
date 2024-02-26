# 🛡️ NetPurge 🛡️

NetPurge is a Bash script that leverages tools like Dsniff, arp-scan, and netdiscover to automate ARP packet interception on a local network. Its primary aim is to block internet access for intruders connecting to your local network.

## 🚀 Installation

Before running NetPurge, make sure you have the following tools installed:

- [Dsniff](https://www.monkey.org/~dugsong/dsniff/)
- [arp-scan](https://github.com/royhills/arp-scan)
- [netdiscover](https://github.com/alexxy/netdiscover)

You can install these tools on Debian/Ubuntu-based systems with the following commands:

```bash
sudo apt update
sudo apt install dsniff arp-scan netdiscover
```

Once the tools are installed, follow these steps to install and run NetPurge:

1. Clone the NetPurge repository from GitHub:

```bash
git clone https://github.com/Arbolencio/NetPurge.git
cd NetPurge
```

2. Grant execution permissions to the script:

```bash
chmod +x NetPurge.sh
```

3. Run NetPurge:

```bash
./NetPurge.sh
```

## Usage

When running NetPurge, you'll be prompted to enter the network interface you want to analyze and the IP address of the target you want to block internet access for.

## Screenshot

![screenshot](https://github.com/Arbolencio/NetPurge/blob/main/NetPurge.PNG?raw=true)

