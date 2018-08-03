#!/bin/bash
# Configures a network with a given SSID and optional Password
# by edditing the configuration file specified by "DIR"
# Usage:
#	./addNetwork.sh <SSID> <Password>

DIR=/etc/wpa_supplicant/wpa_supplicant.conf
SSID=$1
PASSWORD=$2

# Colors
ERROR=$(tput setaf 1)
SUCESS=$(tput setaf 2)
MESSAGE=$(tput setaf 6)
NORMAL=$(tput setaf 9)

# Check first argument
if [ -z ${1+x} ]
then
	printf "\n\n${ERROR}ERROR: No SSID parameter given!${NORMAL}\n"
	printf "\nUsage:\n\t./addNetwork.sh <SSID> <Password>\n\n"
	exit 1
fi

# Check second argument
if [ -z ${2+x} ]
then
	printf "\n\n${MESSAGE}MESSSAGE: No Password parameter given. Network is unprotected.${NORMAL}\n"
fi

# Edit configuration file
echo "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev" > $DIR
echo "update_config=1" >> $DIR
echo "network={" >> $DIR
echo "  ssid=\""$SSID"\"" >> $DIR
if [ ! -z ${2+x} ]
then
    echo "  psk=\""$PASSWORD"\"" >> $DIR
else
    echo "  key_mgmt=NONE" >> $DIR
fi
echo "}" >> $DIR


printf "\nNetwork added successfully!\n\n"
exit 0

