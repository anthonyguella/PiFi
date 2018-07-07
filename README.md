# PiFi

PiFi allows you to set the network settings of a raspberry pi by turning it into a hotspot with the click of a button.

This project is currently under development. The end goal is to create an iPhone app that can set the new wifi credentials.


## Installation

PiFi requires Raspbian Jessie. Stretch is not yet supported. These instructions assume a clean install.

#### Update Raspbian
```sh
$ sudo apt-get update
$ sudo apt-get upgrade
```

#### Install dependencies:

```sh
$ sudo apt-get install hostapd
$ sudo apt-get install dnsmasq
```

Next we have to disable hostapd and dnsmasq from launching on startup. This is because we only want to go into AP mode when the button is pressed.

```sh
$ sudo systemctl disable hostapd
$ sudo systemctl disable dnsmasq
```

#### Install Service

```sh
$ sudo ./install.sh
```

License
----

MIT
