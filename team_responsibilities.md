# 👥 Team Members Responsibilities

## 🎬 Overview

The project presentation is divided among 6 members to ensure clear coverage of all technical requirements. Each member is responsible for both **explaining concepts** and **demonstrating them live**.

---

# 👤 Karlos — System Architecture & Docker (Lead)

## 🎯 Responsibilities

* Introduce the project concept (“Company OS”)
* Explain why Docker is used
* Describe Dockerfile structure and layers
* Explain build optimization and environment setup
* Explain ENTRYPOINT vs CMD

## 🧪 Demo Tasks

```bash
docker build -t midterm .
docker run -it midterm
docker ps
cat /etc/timezone
```

## 💡 Key Concepts

* Docker architecture (image vs container)
* Environment variables
* Build efficiency
* Container lifecycle

---

# 👤 Erik — System Setup & Core Infrastructure

## 🎯 Responsibilities

* Explain installed packages and their purposes
* Explain timezone configuration
* Explain system preparation steps

## 🧪 Demo Tasks

```bash
which sudo
which vim
which grep
cat /etc/timezone
```

## 💡 Key Concepts

* Package management (apt)
* System configuration
* Environment setup

---

# 👤 Igris — Users & Groups (Identity Management)

## 🎯 Responsibilities

* Explain department structure (HR, Engineering, Finance)
* Explain group creation
* Explain user creation and assignment

## 🧪 Demo Tasks

```bash
cat /etc/passwd
cat /etc/group
id hr1
id eng1
```

## 💡 Key Concepts

* User management
* Group-based access
* Identity architecture

---

# 👤 Nick — Permissions & Security ⭐

## 🎯 Responsibilities

* Explain file permissions (chmod, chown)
* Explain SGID and Sticky Bit
* Demonstrate access control between departments

## 🧪 Demo Tasks

```bash
ls -ld /company_data/*
su hr1
cd /company_data/Engineering   # should fail
```

## 💡 Key Concepts

* Access control
* Data isolation
* Advanced permissions (SGID, Sticky Bit)

---

# 👤 William — Filesystem & Automation

## 🎯 Responsibilities

* Explain directory structure
* Explain hard links vs symbolic links
* Explain audit script (grep, awk, redirection)

## 🧪 Demo Tasks

```bash
ls -l /company_data/Engineering
./audit.sh
cat /report.txt
```

## 💡 Key Concepts

* Filesystem hierarchy
* Links (hard vs symbolic)
* Text processing (grep, awk)
* I/O redirection

---

# 👤 Vii — Innovation Features 🚀

## 🎯 Responsibilities

* Explain self-healing entrypoint
* Explain backup system and cron job
* Explain onboarding function
* Explain sudo logging

## 🧪 Demo Tasks

```bash
./backup.sh
cat /var/log/sudo.log
onboard engineering newuser
```

Restart container to show:

* permissions reset automatically

## 💡 Key Concepts

* Automation (cron)
* Logging & auditing
* System resilience
* Advanced scripting

---

# 🏆 Presentation Tips

* Each member should speak for **2–3 minutes**
* Always **demonstrate commands live**
* Avoid repeating explanations
* Use technical terms:

  * “access control”
  * “data isolation”
  * “automation”
  * “system integrity”

---

# ✅ Final Flow

1. Member 1 — Intro + Docker
2. Member 2 — System setup
3. Member 3 — Users & groups
4. Member 4 — Permissions
5. Member 5 — Filesystem & scripts
6. Member 6 — Innovation features

---

This structure ensures:

* Full coverage of requirements
* Clear individual contributions
* Strong presentation for maximum marks
