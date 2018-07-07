#!/bin/bash

HOSTCONFDIR=/etc/hostapd/hostapd.conf
HOSTAPDDIR=/etc/default/hostapd
DNSMASQCONF=/etc/dnsmasq.conf

# Hostapd Configuration
cat > $HOSTCONFDIR << EOL
interface=wlan0
driver=nl80211
ssid=PiFi
hw_mode=g
channel=6
EOL

# Hostapd Defaults
cat > $HOSTAPDDIR << EOL
DAEMON_CONF="/etc/hostapd/hostapd.conf"
EOL

# DNSmasq Configuration
cat > $DNSMASQCONF << EOL
interface=wlan0
bind-dynamic 
domain-needed
bogus-priv
dhcp-range=192.168.50.150,192.168.50.200,255.255.255.0,12h
EOL