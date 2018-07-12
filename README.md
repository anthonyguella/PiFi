# PiFi

## About 

PiFi allows you to set the network settings of a raspberry pi through a webserver.
The pi will automatically go into hotspot mode when disconnected from wifi.

## QuickStart

#### Installation

This version of PiFi was developed for Raspbian Stretch. Older versions may have unintended behavior.

```sh
$ sudo ./install.sh
```

#### Usage

When no network is detected, the pi will become an unprotected hotspot with the SSID: `PiFi`

The ip of the pi is static and is set to: `192.168.50.5`

The webserver is run on `192.168.50.5:5000` and the following commands are avaliable:

| Path  | Type | Description |
| ------------- | ------------- | ------------- |
| / | GET | Returns "PiFi" to verify that you are connected to a PiFi device|
| /wifi/{SSID}/{Password}  | POST | Sets the provided SSID and Password and attempts to connect |
| /wifi/{SSID}  | POST  | Same as above but for unprotected networks |


##### Uninstall

```sh
$ sudo ./uninstall.sh
```

License
----

MIT
