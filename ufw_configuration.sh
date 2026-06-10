#!/bin/bash
# ============================================================
# Task 2: Basic Firewall Configuration with UFW
# Tool: UFW (Uncomplicated Firewall)
# Author: Cybersecurity Intern - Oasis Infobyte
# Date: 2024-01-15
# ============================================================

echo "=========================================="
echo " UFW Firewall Configuration Script"
echo "=========================================="

# Step 1: Install UFW (if not already installed)
echo "[*] Installing UFW..."
sudo apt update -y
sudo apt install ufw -y

# Step 2: Reset UFW to defaults (clean slate)
echo "[*] Resetting UFW to default settings..."
sudo ufw --force reset

# Step 3: Set default policies
# Deny all incoming traffic by default (whitelist approach)
# Allow all outgoing traffic by default
echo "[*] Setting default policies..."
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Step 4: Allow SSH (port 22) - IMPORTANT: Do this before enabling!
# Without this, you will be locked out of the machine
echo "[*] Allowing SSH (port 22)..."
sudo ufw allow ssh
# OR explicitly:
# sudo ufw allow 22/tcp

# Step 5: Deny HTTP traffic (port 80)
echo "[*] Denying HTTP traffic (port 80)..."
sudo ufw deny 80/tcp
sudo ufw deny http

# Step 6: (Optional) Allow HTTPS if needed
echo "[*] Allowing HTTPS (port 443)..."
sudo ufw allow 443/tcp
sudo ufw allow https

# Step 7: Enable UFW
echo "[*] Enabling UFW..."
sudo ufw --force enable

# Step 8: Show final status with rules
echo ""
echo "=========================================="
echo " UFW Status and Active Rules"
echo "=========================================="
sudo ufw status verbose

echo ""
echo "[+] Firewall configuration complete!"
echo "[+] Run 'sudo ufw status numbered' to see numbered rules"
echo "[+] Run 'sudo ufw delete [number]' to remove a rule"
