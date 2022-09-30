#!/bin/bash

# Get the latest AWS IP ranges
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json > /tmp/aws-ip-ranges.json

# grep the JSON for the IP ranges
grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}/[0-9]{1,2}" /tmp/aws-ip-ranges.json > /data/lists/aws-ip-ranges.txt