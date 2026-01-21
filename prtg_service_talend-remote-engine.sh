#!/bin/bash

#############################################
#  Talend Remote Engine status check script
#  Works on old servers (no service)
#  and new servers with a systemd service.
#############################################

# Step 1: Check if Talend-Remote-Engine service exists (Ubuntu 24.04+)
SERVICE="Talend-Remote-Engine.service"

if systemctl list-unit-files | grep -q "^${SERVICE}"; then
    # Service exists, use systemctl to check status
    status_line=$(systemctl status "$SERVICE" 2>/dev/null | grep "Active:")

    if echo "$status_line" | grep -q "active (running)"; then
        echo "OK"
        exit 0
    else
        echo "FAILED"
        exit 1
    fi
fi

# Step 2: Fallback for older servers — detect running wrapper process
if ps aux | grep -i "Talend-Remote-Engine-wrapper" | grep -v grep >/dev/null; then
    echo "OK"
else
    echo "FAILED"
fi
