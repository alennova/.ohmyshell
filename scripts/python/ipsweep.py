#!/usr/bin/env python3

import sys         # Import sys module for command-line argument handling
import subprocess  # Import subprocess to run shell commands (for ping)
import ipaddress   # Import ipaddress to handle and validate IP addresses

# Colors for output
GREEN = "\033[32m"  # ANSI escape code for green text (reachable)
RED = "\033[31m"    # ANSI escape code for red text (unreachable)
NC = "\033[0m"      # ANSI escape code to reset text color to default

# Function to ping an IP address
def ping_ip(ip):
    try:
        # Run the `ping` command with the following options:
        # -c 1: Send only 1 packet
        # -W 1: Timeout after 1 second if no response
        # `stdout=subprocess.DEVNULL` and `stderr=subprocess.DEVNULL` suppress output
        result = subprocess.run(
            ["ping", "-c", "1", "-W", "1", str(ip)], 
            stdout=subprocess.DEVNULL, 
            stderr=subprocess.DEVNULL
        )
        # Check the return code of the ping command
        if result.returncode == 0:  # 0 means success (reachable)
            return True
        else:  # Non-zero return code means failure (unreachable)
            return False
    except Exception:
        return False  # If any exception occurs, assume the ping failed

# Main function
def main():
    # Check if two arguments (start and end IP) are provided
    if len(sys.argv) != 3:
        # If incorrect arguments, print usage instructions and exit
        print("Usage: {} <start-ip> <end-ip>".format(sys.argv[0]))
        print("Example: {} 192.168.1.1 192.168.1.100".format(sys.argv[0]))
        sys.exit(1)  # Exit the script with an error code

    # Parse the start and end IP addresses from the arguments
    try:
        start_ip = ipaddress.IPv4Address(sys.argv[1])  # Validate and convert the first argument to an IPv4 address
        end_ip = ipaddress.IPv4Address(sys.argv[2])    # Validate and convert the second argument to an IPv4 address
    except ipaddress.AddressValueError as e:
        # If the input is not a valid IP address, print an error message and exit
        print(f"Invalid IP address: {e}")
        sys.exit(1)

    # Ensure that the start IP is less than or equal to the end IP
    if start_ip > end_ip:
        print(f"Error: Start IP ({start_ip}) is greater than End IP ({end_ip}).")
        sys.exit(1)  # Exit the script with an error code

    # Initialize counters for reachable and unreachable hosts
    reachable_count = 0      # Counter for reachable hosts
    unreachable_count = 0    # Counter for unreachable hosts

    # Print the range being scanned
    print(f"Scanning range: {start_ip} to {end_ip}")

    # Loop through all IP addresses in the range from start_ip to end_ip
    for ip_int in range(int(start_ip), int(end_ip) + 1):
        ip = ipaddress.IPv4Address(ip_int)  # Convert the integer to an IPv4 address
        # Ping the current IP and check if it is reachable
        if ping_ip(ip):
            # If reachable, print the IP with green color
            print(f"{ip} {GREEN}reachable{NC}")
            reachable_count += 1  # Increment the reachable counter
        else:
            # If unreachable, print the IP with red color
            print(f"{ip} {RED}unreachable{NC}")
            unreachable_count += 1  # Increment the unreachable counter

    # Calculate the total number of hosts scanned
    total = reachable_count + unreachable_count

    # Print the summary of the scan
    print("\nScan complete. Summary:")
    print(f"{GREEN}{reachable_count} reachable{NC} of {total}")  # Print reachable count in green
    print(f"{RED}{unreachable_count} unreachable{NC} of {total}")  # Print unreachable count in red

# Run the main function only if the script is executed directly
if __name__ == "__main__":
    main()
