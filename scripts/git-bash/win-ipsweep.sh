#!/bin/bash

# Colors for output (Git Bash supports ANSI colors, but they may not display well)
GREEN="\033[32m"  # Green color for reachable IPs
RED="\033[31m"    # Red color for unreachable IPs
NC="\033[0m"      # No color (resets the color to default)

# Check if the user provided exactly two arguments (start and end IP)
if [ $# -ne 2 ]; then
    echo "Usage: $0 <start-ip> <end-ip>"
    echo "Example: $0 192.168.1.1 192.168.1.100"
    exit 1
fi

# Assign the arguments to variables
START_IP=$1
END_IP=$2

# Function to convert an IP address into a numeric value
ip_to_num() {
    local ip=$1
    local a b c d
    IFS=. read -r a b c d <<< "$ip"
    echo $((a * 256**3 + b * 256**2 + c * 256 + d))
}

# Function to convert a numeric value back into an IP address
num_to_ip() {
    local num=$1
    echo "$(( (num >> 24) & 255 )).$(( (num >> 16) & 255 )).$(( (num >> 8) & 255 )).$(( num & 255 ))"
}

# Convert start and end IPs into numeric values
START_NUM=$(ip_to_num "$START_IP")
END_NUM=$(ip_to_num "$END_IP")

# Validate IP range
if [ "$START_NUM" -gt "$END_NUM" ]; then
    echo "Error: Start IP ($START_IP) is greater than End IP ($END_IP)."
    exit 1
fi

# Initialize counters
REACHABLE_COUNT=0
UNREACHABLE_COUNT=0

echo "Scanning range: $START_IP to $END_IP"

# Loop through the IP range
for (( ip_num=START_NUM; ip_num<=END_NUM; ip_num++ )); do
    CURRENT_IP=$(num_to_ip $ip_num)
    
    # Windows ping: -n for count, -w in milliseconds
    ping -n 1 -w 1000 $CURRENT_IP > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e " ${CURRENT_IP} ${GREEN}Host is up${NC}"
        ((REACHABLE_COUNT++))
    else
        echo -e " ${CURRENT_IP} ${RED}?${NC}"
        ((UNREACHABLE_COUNT++))
    fi
done

# Summary
TOTAL=$((REACHABLE_COUNT + UNREACHABLE_COUNT))
echo -e "\nScan complete. Summary:"
echo -e "${GREEN}${REACHABLE_COUNT} reachable${NC} of ${TOTAL}"
echo -e "${RED}${UNREACHABLE_COUNT} unreachable${NC} of ${TOTAL}"
