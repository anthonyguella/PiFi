#!/bin/bash

arg=$1
DIR=/etc/dhcpcd.conf

if [[ "$arg" == "start" ]]; then
    echo 'Starting Access Point'
    sudo systemctl start hostapd.service && sudo systemctl start dnsmasq.service
    echo 'nohook wpa_supplicant' >> $DIR
    echo 'interface wlan0' >> $DIR
    echo 'static ip_address=192.168.50.10/24' >> $DIR
    echo 'static routers=192.168.50.1' >> $DIR

elif [[ "$arg" == "stop" ]]; then
    echo 'Stopping Access Point'
    sudo systemctl stop hostapd.service && sudo systemctl stop dnsmasq.service
    sudo head -n -4 /etc/dhcpcd.conf > temp.txt ; sudo mv temp.txt /etc/dhcpcd.conf
else
    echo 'Invalid Argument'
fi

sudo systemctl daemon-reload
sudo systemctl restart dhcpcd