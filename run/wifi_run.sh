#!/bin/sh

if [ "z""$SSID" == "z" -o "z""$PSK" == "z" ]; then        
	SSID='"@@@@@@@@"'
        PSK='"1234567890"'
fi

if [ "z""$NAME" == "z" ]; then        
	NAME=centos_XM
fi
rmmod mt7601Usta
killall wpa_supplicant
killall dhclient

insmod ../driver/os/linux/mt7601Usta.ko
wpa_supplicant -c /etc/wpa_supplicant/wpa_supplicant.conf -i ra0 -B
wpa_cli remove_network 0
wpa_cli ap_scan 1
wpa_cli add_network
wpa_cli set_network 0 ssid $SSID
wpa_cli set_network 0 psk $PSK
wpa_cli select_network 0
wpa_cli list_networks
dhclient ra0 -H $NAME
