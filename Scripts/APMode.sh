#!/bin/bash

arg=$1

if [[ "$arg" == "start" ]]; then
    echo Starting Access Point
    sudo systemctl start hostapd.service && systemctl start dnsmasq.service
elif [[ "$arg" == "stop" ]]; then
    echo Stopping Access Point
    sudo systemctl stop hostapd.service && systemctl stop dnsmasq.service
else
    echo Invalid Argument
fi
