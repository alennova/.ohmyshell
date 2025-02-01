#!/bin/bash

# Colors for output to make it visually distinct
GREEN="\e[32m"  # Green color for reachable IPs
RED="\e[31m"    # Red color for unreachable IPs
NC="\e[0m"      # No color (resets the color to default)

# Check if the user provided exactly two arguments (start and end IP)
if [ $# -ne 2 ]; then
    # If the number of arguments is not equal to 2, show usage instructions
    echo "Usage: $0 <start-ip> <end-ip>"
    echo "Example: $0 192.168.1.1 192.168.1.100"
    exit 1  # Exit the script with an error code
fi

# Assign the arguments to variables
START_IP=$1  # First argument is the starting IP address
END_IP=$2    # Second argument is the ending IP address

# Function to convert an IP address into a numeric value for easy comparison
ip_to_num() {
    local ip=$1  # Input IP address
    local a b c d
    IFS=. read -r a b c d <<< "$ip"  # Split the IP into four octets using '.' as a delimiter
    # Calculate the numeric value (weighted sum of the octets)
    echo $((a * 256**3 + b * 256**2 + c * 256 + d))
}

# Function to convert a numeric value back into an IP address
num_to_ip() {
    local num=$1  # Input numeric value
    # Extract each octet by using bitwise operations and print it in IP format
    echo "$(( (num >> 24) & 255 )).$(( (num >> 16) & 255 )).$(( (num >> 8) & 255 )).$(( num & 255 ))"
}

# Convert the start and end IPs into numeric values for range processing
START_NUM=$(ip_to_num "$START_IP")
END_NUM=$(ip_to_num "$END_IP")

# Validate that the start IP is less than or equal to the end IP
if [ "$START_NUM" -gt "$END_NUM" ]; then
    echo "Error: Start IP ($START_IP) is greater than End IP ($END_IP)."
    exit 1  # Exit the script with an error code
fi

# Initialize counters for tracking reachable and unreachable hosts
REACHABLE_COUNT=0      # Counter for reachable hosts
UNREACHABLE_COUNT=0    # Counter for unreachable hosts

# Print the range being scanned
echo "Scanning range: $START_IP to $END_IP"

# Loop through the numeric range from START_NUM to END_NUM
for (( ip_num=START_NUM; ip_num<=END_NUM; ip_num++ )); do
    # Convert the current numeric value into an IP address
    CURRENT_IP=$(num_to_ip $ip_num)
    
    # Ping the current IP address with a timeout of 1 second, suppressing output
    ping -c 1 -W 1 $CURRENT_IP &> /dev/null
    if [ $? -eq 0 ]; then
        # If the ping succeeds, the host is reachable
        echo -e " ${CURRENT_IP} ${GREEN}Host is up${NC}"  # Print in green
        ((REACHABLE_COUNT++))  # Increment the reachable counter
    else
        # If the ping fails, the host is unreachable
        echo -e " ${CURRENT_IP} ${RED}?${NC}"  # Print in red
        ((UNREACHABLE_COUNT++))  # Increment the unreachable counter
    fi
done

# Calculate the total number of hosts scanned
TOTAL=$((REACHABLE_COUNT + UNREACHABLE_COUNT))

# Print the summary of the scan
echo -e "\nScan complete. Summary:"
echo -e "${GREEN}${REACHABLE_COUNT} reachable${NC} of ${TOTAL}"  # Print reachable count in green
echo -e "${RED}${UNREACHABLE_COUNT} unreachable${NC} of ${TOTAL}"  # Print unreachable count in red
