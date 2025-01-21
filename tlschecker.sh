#!/bin/bash

# Check root user
if [[ $(id -u) -ne 0  ]];then
        echo "Please execute as root"
        exit 1
fi

# Check if 1 argument is added
if [[ $# -ne 1 ]]; then
        echo "Usage: $0 example.com"
        exit 1
fi

# Create variables
validity=$(nmap --script ssl-cert $1 | grep "Not valid after" | cut -d ":" -f 2 | cut -d "T" -f 1)
onemonth=$(date -d "+1 month" +"%Y-%m-%d")

# Check validity
if [[ "$validity" < "$onemonth" ]]; then
    echo "Update NOW!"
else
        echo "Everything is fine, the certificate is valid until:$validity"
fi
