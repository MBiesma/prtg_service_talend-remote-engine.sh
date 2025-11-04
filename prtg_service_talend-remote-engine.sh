#!/bin/bash

# Get the line containing 'Active:'
status_line=$(systemctl status talend-remote-engine | grep "Active:")

# Check if the status contains 'active (running)'
if echo "$status_line" | grep -q "active (running)"; then
    echo "OK"
else
    echo "FAILED"
fi
