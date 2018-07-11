#!/bin/bash

HOSTCONFDIR=/etc/hostapd/hostapd.conf
HOSTAPDDIR=/etc/default/hostapd
DNSMASQCONF=/etc/dnsmasq.conf

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
sudo cp ./Config/Host/hostapd /etc/defaut/hostapd

# DNSmasq Configuration
sudo cp ./Config/Host/dnsmasq.conf /etc/dnsmasq.conf

# Webserver Setup
sudo cp ./Scripts/

# APModeService Setup
sudo cp ./Scripts/autohotspot.service /etc/ /etc/systemd/system/autohotspot.service
sudo systemctl enable autohotspot.service   