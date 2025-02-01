#!/usr/bin/env php
<?php

// Define ANSI escape codes for colored terminal output
define("GREEN", "\033[32m"); // Green for reachable
define("RED", "\033[31m");   // Red for unreachable
define("NC", "\033[0m");     // Reset color to default

/**
 * Function to ping an IP address.
 * 
 * @param string $ip The IP address to ping.
 * @return bool True if the IP is reachable, false otherwise.
 */
function pingIp($ip) {
    $output = null;         // Variable to store output of the ping command
    $resultCode = null;     // Variable to store the return code of the ping command

    // Execute the ping command with the following options:
    // -c 1: Send only one ping packet
    // -W 1: Set timeout to 1 second
    // Redirect output to /dev/null to suppress it
    exec("ping -c 1 -W 1 $ip > /dev/null 2>&1", $output, $resultCode);

    // Return true if the ping command was successful (return code 0)
    return $resultCode === 0;
}

/**
 * Main function to handle the IP sweep logic.
 */
function main() {
    global $argv; // Access global arguments passed to the script

    // Check if the correct number of arguments is provided
    if (count($argv) !== 3) {
        // Print usage instructions if arguments are incorrect
        echo "Usage: php " . $argv[0] . " <start-ip> <end-ip>\n";
        echo "Example: php " . $argv[0] . " 192.168.1.1 192.168.1.100\n";
        exit(1); // Exit with error code 1
    }

    // Retrieve start and end IP addresses from arguments
    $startIp = $argv[1];
    $endIp = $argv[2];

    // Validate that the provided IP addresses are valid IPv4 addresses
    if (!filter_var($startIp, FILTER_VALIDATE_IP) || !filter_var($endIp, FILTER_VALIDATE_IP)) {
        echo "Invalid IP address provided. Please enter valid IPv4 addresses.\n";
        exit(1); // Exit with error code 1
    }

    // Convert IP addresses to long integers for range processing
    $startLong = ip2long($startIp); // Convert start IP to integer
    $endLong = ip2long($endIp);     // Convert end IP to integer

    // Ensure the start IP is less than or equal to the end IP
    if ($startLong > $endLong) {
        echo "Error: Start IP ($startIp) is greater than End IP ($endIp).\n";
        exit(1); // Exit with error code 1
    }

    // Initialize counters for reachable and unreachable hosts
    $reachableCount = 0;      // Counter for reachable hosts
    $unreachableCount = 0;    // Counter for unreachable hosts

    // Print the range being scanned
    echo "Scanning range: $startIp to $endIp\n";

    // Loop through all IP addresses in the specified range
    for ($ipLong = $startLong; $ipLong <= $endLong; $ipLong++) {
        // Convert the current integer back to an IP address
        $currentIp = long2ip($ipLong);

        // Check if the current IP is reachable
        if (pingIp($currentIp)) {
            // If reachable, print the IP in green
            echo $currentIp . GREEN . " reachable" . NC . "\n";
            $reachableCount++; // Increment reachable counter
        } else {
            // If unreachable, print the IP in red
            echo $currentIp . RED . " unreachable" . NC . "\n";
            $unreachableCount++; // Increment unreachable counter
        }
    }

    // Calculate the total number of hosts scanned
    $total = $reachableCount + $unreachableCount;

    // Print the summary of the scan
    echo "\nScan complete. Summary:\n";
    echo GREEN . "$reachableCount reachable" . NC . " of $total\n"; // Print reachable count in green
    echo RED . "$unreachableCount unreachable" . NC . " of $total\n"; // Print unreachable count in red
}

// Call the main function to execute the script logic
main();
