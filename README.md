
# Talend Remote Engine Monitoring Script

This repository contains a Linux shell script designed to monitor the status of the **Talend Remote Engine** across different generations of servers. It supports both older systems—where the Talend Remote Engine runs only as a wrapper process—and modern systems such as **Ubuntu 24.04**, where Talend provides a proper **systemd service**.

The script is intended for use with monitoring tools such as **PRTG Network Monitor**, but it can also be used standalone.

---

## Features
- ✔ Detects whether `Talend-Remote-Engine.service` exists on the system
- ✔ Uses `systemctl` for modern servers where the service is present
- ✔ Falls back to process detection for older servers
- ✔ Provides clean output: `OK` or `FAILED`
- ✔ Compatible with PRTG custom sensors
- ✔ Does *not* interfere with Talend Runtime monitoring

---

## How It Works
The script performs two automatic detection steps:

### **1. Service Detection (Modern Servers)**
If the server provides a systemd unit named:
```
Talend-Remote-Engine.service
```
the script reads its status using:
```
systemctl status Talend-Remote-Engine.service
```
If the service is listed as **active (running)**, the script outputs:
```
OK
```
otherwise:
```
FAILED
```

This behavior matches how Talend runs on Ubuntu 24.04 and later.

### **2. Process Detection (Older Servers)**
If the systemd service does *not* exist, the script checks for a running Talend wrapper process:
```
ps aux | grep -i "Talend-Remote-Engine-wrapper"
```
If the wrapper process is present, it returns:
```
OK
```
Otherwise, it returns:
```
FAILED
```

## Installation
1. Copy the script to your server, typically under:
```
/var/prtg/scripts/
```
2. Make the script executable:
```
chmod +x prtg_service_talend_remote_engine.sh
```
3. Run it manually to test:
```
./prtg_service_talend_remote_engine.sh
```

Expected output:
- `OK` → Talend Remote Engine is running
- `FAILED` → Talend Remote Engine is not running

---

## Compatibility
This script has been tested on:
- Ubuntu 18.04
- Ubuntu 20.04
- Ubuntu 22.04
- Ubuntu 24.04 (with systemd Talend service)
- RHEL/CentOS 7 & 8
- Debian 10 & 11

It should work on any Linux distribution using **systemd**.

---

## License
This script is free to use, modify, and distribute without restrictions.

---

## Contributing
Pull requests are welcome. If you want support for Talend Runtime or multi-sensor XML output for PRTG, feel free to open an issue.
