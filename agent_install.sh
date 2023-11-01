#!/bin/bash

# Define the Zabbix Agent download URL and installation directory
ZABBIX_AGENT_URL="https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.4-1+ubuntu20.04_all.deb"
INSTALL_DIR="/tmp"

# Check if Zabbix Agent is already installed
if dpkg -l | grep zabbix-agent; then
    echo "Zabbix Agent is already installed. Skipping installation."
    exit 0
fi

# Download and install the Zabbix Agent
echo "Downloading the Zabbix Agent..."
wget -q $ZABBIX_AGENT_URL -P $INSTALL_DIR
if [ $? -ne 0 ]; then
    echo "Failed to download the Zabbix Agent package."
    exit 1
fi

echo "Installing the Zabbix Agent..."
dpkg -i $INSTALL_DIR/zabbix-release_5.4-1+ubuntu20.04_all.deb

# Update the package list
apt update

# Install the Zabbix Agent
apt install -y zabbix-agent

# Start and enable the Zabbix Agent service
systemctl start zabbix-agent
systemctl enable zabbix-agent

# Clean up the downloaded package
rm $INSTALL_DIR/zabbix-release_5.4-1+ubuntu20.04_all.deb

echo "Zabbix Agent installation complete."
