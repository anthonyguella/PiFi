#!/bin/bash

DIR=/etc/wpa_supplicant/wpa_supplicant.conf
SSID=$1
PASSWORD=$2

echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > $DIR
echo "update_config = 1" >> $DIR
echo "network={" >> $DIR
echo "  ssid="$SSID"" >> $DIR
if [[ "$PASSWORD" != "" ]]; then
    echo "  psk="$PASSWORD"" >> $DIR
else
    echo "  key_mgmt=NONE" >> $DIR
fi
echo "}" >> $DIR