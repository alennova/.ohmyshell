#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <ip_range> (e.g., 192.168.1.1-100)"
    exit 1
fi

ip_range=$1

# Validate IP range format
if ! [[ "$ip_range" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}-[0-9]{1,3}$ ]]; then
    echo "Error: Invalid IP range format. Use e.g., 192.168.1.1-100"
    exit 1
fi

echo "Scanning IP range: $ip_range using nmap..."

# Run nmap on the specified range
nmap -sn "$ip_range" | awk '/Nmap scan report/{ip=$NF} /MAC Address/{print ip, $3}'