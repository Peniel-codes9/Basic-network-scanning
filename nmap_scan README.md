# Basic-network-scanning
Basic network scanning using nmap.

# Task 1: Basic Network Scanning with Nmap

## Objective
Perform a network scan to identify open ports and services using Nmap.

## Tool Used
- **Nmap** (Network Mapper) v7.95

## Target
- **Host:** scanme.nmap.org
- **IP:** 45.33.32.156
- **Note:** scanme.nmap.org is an official Nmap practice server, authorized for scanning.

## What is Nmap?
Nmap is a free, open-source network scanner used to discover hosts and services
on a computer network. It sends specially crafted packets to target hosts and
analyzes responses to build a map of the network.

## Steps Performed

### 1. Installation
Nmap was pre-installed on Kali Linux.
```bash
nmap --version
# Nmap 7.95
```

### 2. Scan Command Used
```bash
nmap -sV -sC scanme.nmap.org
```

**Flags Explained:**
 Flag -  Meaning 
 `-sV` - Detect service/version info 
 `-sC` - Run default NSE scripts 

### 3. Scan Results

| Port  | State    | Service  | Version               |
|-------|----------|----------|-----------------------|
| 80    | OPEN     | HTTP     | Apache httpd 2.4.7 (Ubuntu) |
| 111   | filtered | rpcbind  | — |
| 119   | filtered | nntp     | — |
| 465   | filtered | smtps    | — |
| 514   | filtered | shell    | — |
| 544   | filtered | kshell   | — |
| 2000  | filtered | cisco-sccp | — |
| 2001  | filtered | dc       | — |
| 2121  | filtered | ccproxy-ftp | — |
| 3986  | filtered | mapper-ws-ethd | — |
| 5631  | filtered | pcanywheredata | — |
| 6000  | filtered | X11      | — |
| 7070  | filtered | realserver | — |
| 8000  | filtered | http-alt | — |
| 9999  | filtered | abyss    | — |
| 32768 | filtered | filenet-tms | — |

**OS Detected:** Linux (Ubuntu) — cpe:/o:linux:linux_kernel

### 4. Key Findings

#### Port 80 - HTTP (OPEN)
- Apache 2.4.7 running on Ubuntu Linux
- Page title: "Go ahead and ScanMe!" — confirms official Nmap target
- **Risk:** Apache 2.4.7 is outdated; unencrypted HTTP traffic
- **Fix:** Upgrade Apache; enable HTTPS; redirect HTTP → HTTPS

#### Filtered Ports (15 ports)
- Blocked by a firewall — Nmap cannot determine open/closed state
- **Risk:** Low — firewall is actively protecting the server
- **Good practice:** Default-deny firewall policy in place

### 5. Scan Statistics
- **Scan duration:** 22.57 seconds
- **Hosts up:** 1
- **Open ports:** 1
- **Filtered ports:** 15

## Recommendations
1. Upgrade Apache from 2.4.7 to latest version (security patches)
2. Enable HTTPS (port 443) with a valid SSL certificate
3. Firewall is well-configured — most ports properly filtered
4. Consider enabling port 443 for encrypted web traffic

## Files in This Repository
- `nmap_scan_results.txt` — Full Nmap scan output and analysis
- `README.md` — This documentation
- `screenshots/` — Nmap terminal screenshots

## References
- [Nmap Official Docs](https://nmap.org/docs.html)
- [scanme.nmap.org](http://scanme.nmap.org)
- [Apache CVE Database](https://httpd.apache.org/security/vulnerabilities_24.html)
