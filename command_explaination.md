# EXPLANATION (Simple + Presentation Ready)

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

## 🔹 15. ENTRYPOINT (🔥 INNOVATION)

👉 Resets permissions every startup
