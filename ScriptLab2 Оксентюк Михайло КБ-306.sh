#!/bin/bash

sudo ifconfig wlan0 192.168.10.1 netmask 255.255.255.0 up

x-terminal-emulator -e "bash -c 'sudo hostapd ~/Desktop/hostapd.conf; exec bash'" &

echo -e "\e[36m[INFO]\e[0m Waiting for hostapd..."
while ! pgrep -x "hostapd" > /dev/null; do
  sleep 1
done

sleep 2

echo -e "\e[33m[WARNING]\e[0m Killing existing dnsmasq..."
sudo killall dnsmasq 2>/dev/null

echo -e "\e[32m[START]\e[0m Starting dnsmasq..."
sudo dnsmasq -i wlan0 --no-resolv --no-poll --log-dhcp \
  --dhcp-range=192.168.10.10,192.168.10.50,12h \
  --dhcp-option=3,192.168.10.1 \
  --dhcp-option=6,192.168.10.1 \
  --bind-interfaces \
  --address=/#/192.168.10.1 &

echo -e "\e[32m[START]\e[0m Starting Apache2..."
sudo systemctl start apache2

echo -e "\e[35m[DONE]\e[0m Ready!"
