#!/bin/bash

# Install Dependencies
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install hostapd
sudo apt-get install dnsmasq

# Disable Services
sudo systemctl disable hostapd
sudo systemctl disable dnsmasq

# Hostapd Configuration
sudo cp ./Config/Host/hostapd.conf /etc/hostapd/hostapd.conf
sudo cp ./Config/Host/hostapd /etc/default/hostapd

# DNSmasq Configuration
sudo cp ./Config/Host/dnsmasq.conf /etc/dnsmasq.conf

# Webserver Setup
sudo cp ./Scripts/hotspotWebserver.py /usr/bin/hotspotWebserver.py

# AddNetwork
sudo cp ./Scripts/addNetwork.sh /usr/bin/addNetwork.sh

# APModeService Setup
sudo cp ./Scripts/autohotspot.service /etc/systemd/system/autohotspot.service
sudo cp ./Scripts/autohotspotN /usr/bin/autohotspotN
sudo systemctl enable autohotspot.service   