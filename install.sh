#!/bin/bash

set -e

echo "[+] Update & upgrade package list"
apt-get update -y
apt-get upgrade -y

echo "[+] Install python3, pip & venv"
apt-get install -y python3 python3-pip python3-venv

echo "[+] Upgrade pip"
pip3 install --upgrade pip --break-system-packages 2>/dev/null || pip3 install --upgrade pip

echo "[+] Install Python packages"
pip3 install --break-system-packages colorama aiohttp camoufox 2>/dev/null || \
pip3 install colorama aiohttp camoufox

echo "[+] Install camoufox with geoip support"
pip3 install --break-system-packages "camoufox[geoip]" 2>/dev/null || \
pip3 install "camoufox[geoip]"

echo "[+] Installing Node.js v22"
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt-get install -y nodejs
echo "    Node.js version: $(node -v)"
echo "    npm version:     $(npm -v)"

echo "[+] Install browser dependencies (Playwright/Camoufox)"
apt-get install -y \
  libgtk-3-0 \
  libdbus-glib-1-2 \
  libxt6 \
  libx11-xcb1 \
  libxcomposite1 \
  libxcursor1 \
  libxdamage1 \
  libxext6 \
  libxfixes3 \
  libxi6 \
  libxrandr2 \
  libxrender1 \
  libxss1 \
  libxtst6 \
  libgbm1 \
  libpango-1.0-0 \
  libpangocairo-1.0-0 \
  libcairo2 \
  libgdk-pixbuf2.0-0 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libdrm2 \
  libnss3 \
  libcups2 \
  fonts-liberation 2>/dev/null || true

# libasound2 renamed in Ubuntu 22.04+
apt-get install -y libasound2 2>/dev/null || \
apt-get install -y libasound2t64 2>/dev/null || true

echo "[+] Download camoufox browser"
python3 -m camoufox fetch 2>/dev/null || true

echo ""
echo "[✓] Setup selesai! Camoufox, Node.js v22 & semua dependencies sudah terinstall."
