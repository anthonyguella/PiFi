#!/bin/bash
# Installs bash and python dependencies
# OVERWRITES /etc/ config files

# Colors
ERROR=$(tput setaf 1)
SUCESS=$(tput setaf 2)
MESSAGE=$(tput setaf 6)
NORMAL=$(tput sgr0)

# User warning
printf "\n\n${ERROR}WARNING:${NORMAL} This script will overwrite your system configuration files:\n"
printf "\n\t/etc/hostapd/hostapd.conf"
printf "\n\t/etc/default/hostapd"
printf "\n\t/etc/dnsmasq.conf"
printf "\n\t/etc/dhcpcd.conf"
printf "\n\t/usr/bin/hotspotWebserver.py"
printf "\n\t/usr/bin/addNetwork.sh"
printf "\n\t/etc/systemd/system/autohotspot.service"
printf "\n\t/usr/bin/autohotspotN"

printf "\n\nDo you wish to continue? [Y/N]: "
read CHOICE
if [[ ${CHOICE,,} == "y" ]]
then
	# Install Dependencies
	sudo apt-get update
	sudo apt-get upgrade
	sudo apt-get install hostapd
	sudo apt-get install dnsmasq

	# Install Python dependencies
	pip install Flask
	pip install request
	pip install jsonify

	# Disable Services
	sudo systemctl disable hostapd
	sudo systemctl disable dnsmasq

	# Hostapd Configuration
	sudo cp ./Config/hostapd.conf /etc/hostapd/hostapd.conf
	sudo cp ./Config/hostapd /etc/default/hostapd

	# DNSmasq Configuration
	sudo cp ./Config/dnsmasq.conf /etc/dnsmasq.conf

	# dhcpcd Configuration
	sudo cp ./Config/dhcpcd.conf /etc/dhcpcd.conf

	# Webserver Setup
	sudo cp ./Scripts/hotspotWebserver.py /usr/bin/hotspotWebserver.py

	# AddNetwork
	sudo cp ./Scripts/addNetwork.sh /usr/bin/addNetwork.sh

	# APModeService Setup
	sudo cp ./Scripts/autohotspot.service /etc/systemd/system/autohotspot.service
	sudo cp ./Scripts/autohotspotN /usr/bin/autohotspotN

	# Enable auto hotspot service
	sudo systemctl enable autohotspot.service
else
	printf "\nBye :)\n"
fi
