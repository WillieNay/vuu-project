# Midterm Project Technical Report

**Course:** Linux Administration and Orchestration
**Project:** The Enterprise Container Architect
**Instructor:** Vu
**Date:** February 2026

---

## 👥 Group Members

* Member 1: ____________________
* Member 2: ____________________
* Member 3: ____________________
* Member 4: ____________________
* Member 5: ____________________
* Member 6: ____________________

---

# 1. Introduction

This project focuses on designing and deploying a standardized enterprise Linux environment using Docker. The goal is to simulate a real-world company operating system that includes user management, filesystem organization, security policies, and automation.

By containerizing the system, we ensure consistency, portability, and efficient deployment across environments.

---

# 2. System Architecture

The system follows a layered architecture:

* **Base Layer:** Ubuntu 22.04
* **System Layer:** Installed tools (sudo, vim, nano, grep, awk, cron)
* **User Layer:** Department-based users and groups (HR, Engineering, Finance)
* **Filesystem Layer:** Structured directories under `/company_data`
* **Security Layer:** Permissions, ownership, SGID, and Sticky Bit
* **Automation Layer:** Scripts for auditing and backup
* **Innovation Layer:** Self-healing entrypoint and onboarding automation

This modular structure ensures maintainability and scalability.

---

# 3. Linux Concepts Implementation

| Concept               | Description           | Implementation      |
| --------------------- | --------------------- | ------------------- |
| Users                 | Create system users   | `useradd`           |
| Groups                | Department grouping   | `groupadd`          |
| Permissions           | Access control        | `chmod 770`         |
| Ownership             | Assign file ownership | `chown`             |
| SGID                  | Group inheritance     | `chmod g+s`         |
| Sticky Bit            | Restrict deletion     | `chmod +t`          |
| Sudo                  | Admin privileges      | `/etc/sudoers`      |
| Logging               | Track sudo usage      | `/var/log/sudo.log` |
| Filesystem            | Directory hierarchy   | `/company_data`     |
| Links                 | Hard & symbolic links | `ln`, `ln -s`       |
| Scripts               | Automation scripts    | `bash`              |
| Redirection           | Output handling       | `>`, `2>`           |
| Cron                  | Task scheduling       | `crontab`           |
| Environment Variables | System config         | `ENV`               |

---

# 4. Dockerfile Explanation (Simple + Presentation Ready)

## 🔹 1. ENV

```bash
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Bangkok
```

👉 Prevents prompts and sets timezone (requirement)

---

## 🔹 2. INSTALL PACKAGES

```bash
apt-get install -y sudo tzdata vim nano grep gawk cron
```

👉 Tools for:

* **Admin:** sudo
* **Editing:** vim, nano
* **Processing:** grep, awk
* **Automation:** cron

---

## 🔹 3. COMPANY STRUCTURE

```bash
/company_data/{HR,Engineering,Finance}
```

👉 Simulates departments

---

## 🔹 4–5. USERS & GROUPS

```bash
groupadd hr
useradd -m -g hr hr1
```

👉 Identity management (core requirement)

---

## 🔹 6. PERMISSIONS

```bash
chmod 770
```

👉 Only owner and group can access

---

## 🔹 7. ADVANCED PERMISSIONS

```bash
chmod g+s
```

👉 SGID → files inherit group

```bash
chmod +t
```

👉 Sticky bit → restrict deletion

---

## 🔹 8. SUDO

```bash
eng_lead ALL=(ALL) NOPASSWD:ALL
```

👉 Only lead has admin rights

```bash
Defaults logfile=/var/log/sudo.log
```

👉 Logs sudo usage

---

## 🔹 9. LINKS

```bash
ln
ln -s
```

👉 Hard vs symbolic links

---

## 🔹 10. AUDIT SCRIPT

```bash
grep + awk + > 2>
```

👉 Demonstrates:

* Filtering
* Processing
* Redirection

---

## 🔹 11–12. BACKUP + CRON

👉 Automatic backups every minute

---

## 🔹 13. ONBOARDING

```bash
onboard engineering newuser
```

👉 Automates employee creation

---

## 🔹 14. LOGIN BANNER

👉 Professional system feel

---

## 🔹 15. ENTRYPOINT (Innovation)

👉 Resets permissions every startup

---

# 5. Innovation Features

The project includes several advanced features:

### 🔹 Self-Healing Entrypoint

A script that automatically resets permissions whenever the container starts, ensuring system consistency.

### 🔹 Automated Backup System

A script compresses `/company_data` into a backup archive.

### 🔹 Cron Job Automation

Backups are scheduled to run automatically at regular intervals.

### 🔹 Onboarding Tool

A bash function simplifies adding new users to departments.

### 🔹 Sudo Logging

All administrative actions are logged for security auditing.

---

# 6. Conclusion

This project demonstrates the integration of multiple Linux system administration concepts within a Docker environment. It showcases user and group management, filesystem design, security enforcement, and automation.

The inclusion of innovative features such as self-healing systems and automated backups reflects real-world enterprise practices, making this project both practical and scalable.
