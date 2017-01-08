#!/bin/sh

if [ -n $NAME ]; then        
	NAME=centos_XM
fi

ifconfig ra0 down
sleep 1
modprobe -r mt7601Usta
sleep 1
killall wpa_supplicant
killall dhclient

sleep 1
modprobe mt7601Usta
rm -rf /var/run/wpa_supplicant/ra0
sleep 1
wpa_supplicant -c ./wpa_supplicant.conf -i ra0 -B

if [ ! -n $SSID ] || [ ! -n $PSK ]; then        
	wpa_cli remove_network 0
	wpa_cli ap_scan 1
	wpa_cli add_network
	wpa_cli set_network 0 ssid $SSID
	wpa_cli set_network 0 psk $PSK
	wpa_cli select_network 0
	wpa_cli list_networks
	dhclient ra0 -H $NAME
fi
