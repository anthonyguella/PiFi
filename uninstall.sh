#!/bin/bash

echo "Uninstalling..."
# Hostapd Configuration
sudo rm -f /etc/hostapd/hostapd.conf 
sudo rm -f /etc/default/hostapd

# DNSmasq Configuration
sudo rm -f /etc/dnsmasq.conf

# Webserver Setup
sudo rm -f /usr/bin/hotspotWebserver.py

# AddNetwork
sudo rm -f /usr/bin/addNetwork.sh

# APModeService Setup
sudo cp ./Scripts/autohotspot.service /etc/systemd/system/autohotspot.service
sudo cp ./Scripts/autohotspotN /usr/bin/autohotspotN
sudo systemctl enable autohotspot.service

echo "Successfully uninstalled"