# Task 2: Basic Firewall Configuration with UFW

## Objective
Set up a basic firewall using UFW (Uncomplicated Firewall) on a Linux system to allow SSH and deny HTTP traffic.

## Tool Used
UFW (Uncomplicated Firewall) — a frontend for iptables

## What is UFW?
UFW is a user-friendly interface for managing netfilter firewall rules on Linux. It simplifies the process of configuring iptables, which is the underlying packet-filtering framework in the Linux kernel.

## Steps Performed
### 1. Install UFW
sudo apt update && sudo apt install ufw -y

### 2. Set Default Policies
sudo ufw default deny incoming   # Block all inbound by default
sudo ufw default allow outgoing  # Allow all outbound by default
This "deny by default" approach means only explicitly allowed traffic gets through.

### 3. Allow SSH (Port 22)
sudo ufw allow ssh
> ⚠️ Important: Always allow SSH before enabling UFW — otherwise you'll be locked out of the system!

### 4. Deny HTTP (Port 80)
sudo ufw deny http
sudo ufw deny 80/tcp
### 5. Allow HTTPS (Port 443)
sudo ufw allow https
### 6. Enable the Firewall
sudo ufw --force enable
### 7. Verify Status
sudo ufw status verbose
## Expected Output (ufw status)

Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), disabled (routed)

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere
80/tcp                     DENY IN     Anywhere
443/tcp                    ALLOW IN    Anywhere
22/tcp (v6)                ALLOW IN    Anywhere (v6)
80/tcp (v6)                DENY IN     Anywhere (v6)
443/tcp (v6)               ALLOW IN    Anywhere (v6)
## Explanation of Rules

| Port | Protocol | Action | Reason |
|------|----------|--------|--------|
| 22   | TCP      | ALLOW  | Needed for SSH remote access |
| 80   | TCP      | DENY   | HTTP is unencrypted; traffic blocked |
| 443  | TCP      | ALLOW  | HTTPS is encrypted; allowed |

## Useful UFW Commands

sudo ufw status numbered        # Show rules with numbers
sudo ufw delete [rule_number]   # Remove a rule
sudo ufw disable                # Disable firewall
sudo ufw reset                  # Reset all rules
sudo ufw allow from 192.168.1.0/24  # Allow from a subnet
sudo ufw deny from [IP]         # Block a specific IP

## Files in This Repository
- ufw_configuration.sh — Automated script to configure the firewall
- README.md — This documentation file
- screenshots/ — UFW status screenshots

## References
- [UFW Official Wiki](https://help.ubuntu.com/community/UFW)
- [Digital Ocean UFW Guide](https://www.digitalocean.com/community/tutorials/ufw-essentials-common-firewall-rules-and-commands)
