# Wi-FI-labs-Toolkit
Bash scripts for hands‑on Wi‑Fi security laboratories

---

This repository collects four **Bash** scripts created during networking/security labs.  Each script automates a specific Wi‑Fi attack or defensive setup for **educational purposes only**.  Run them **only** on networks you own or have explicit permission to test.

| Lab | Script file                 | Goal                                                                                         |
| --- | --------------------------- | -------------------------------------------------------------------------------------------- |
| 1.1 | `lab1_monitor_deauth.sh`    | Enable *monitor* mode, scan nearby APs, perform targeted **de‑authentication** attack.       |
| 1.2 | `lab1_mac_spoofing.sh`      | Scan, lock on channel/BSSID, **spoof client MAC**, and restore networking.                   |
| 2   | `lab2_rogue_ap.sh`          | Turn the adapter into a **rogue access point** with *hostapd + dnsmasq* captive portal.      |
| 3   | `lab3_handshake_capture.sh` | Use *bettercap* + *airodump‑ng* to **capture WPA2 handshake** & validate with *aircrack‑ng*. |

---

## Prerequisites

* **Linux** system (tested on Kali)
* Wireless adapter supporting monitor/injection
* `aircrack-ng` suite (`airmon-ng`, `airodump-ng`, `aireplay-ng`, `aircrack-ng`)
* `bettercap`
* `macchanger`
* `hostapd`, `dnsmasq`, `apache2`
* `iptables` (optional, for NAT)

Install on Debian/Kali:

```bash
sudo apt update && sudo apt install aircrack-ng bettercap macchanger hostapd dnsmasq apache2
```

---

## Quick Start

```bash
# 1. clone & enter
git clone https://github.com/<your‑username>/<repo‑name>.git
cd <repo‑name>

# 2. make scripts executable
chmod +x lab*.sh

# 3. run the desired lab script (root required)
sudo ./lab1_monitor_deauth.sh
```

Each script is **interactive**—follow on‑screen prompts for MAC, channel, packet count, etc.

> **Tip:** After a lab, run `sudo airmon-ng stop wlan0` and restart NetworkManager to restore connectivity.

---

## Script Details

<details>
<summary>lab1_monitor_deauth.sh</summary>

* Starts `wlan0` in monitor mode
* Runs test injection, passive scan, & saves CSV
* Prompts for *channel*, *AP MAC*, *packet count* and launches deauth attack

</details>

<details>
<summary>lab1_mac_spoofing.sh</summary>

* Similar initial scan as 1.1
* Locks adapter to chosen channel/BSSID
* Spoofs client MAC with **macchanger**
* Gracefully brings NetworkManager down/up

</details>

<details>
<summary>lab2_rogue_ap.sh</summary>

* Assigns static IP 192.168.10.1/24
* Launches **hostapd** and **dnsmasq** for DHCP/DNS
* Starts Apache2 to serve captive‑portal content

</details>

<details>
<summary>lab3_handshake_capture.sh</summary>

* Uses **bettercap** for multi‑channel recon & bulk deauth
* Captures handshake with **airodump‑ng**
* Automatically feeds `.cap` into **aircrack‑ng** for validation

</details>

---

## Disclaimer

This project is intended **solely for academic research and training**.  Unauthorized use against third‑party networks may be illegal.  The author bears **no responsibility** for misuse.

---

## Author

**Михайло Оксентюк**
Group **КБ‑306**
