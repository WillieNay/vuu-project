FROM ubuntu:22.04

# -----------------------------
# 1. ENVIRONMENT SETUP
# -----------------------------
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Bangkok

# -----------------------------
# 2. INSTALL PACKAGES
# -----------------------------
RUN apt-get update && \
    apt-get install -y sudo tzdata vim nano grep gawk cron && \
    ln -fs /usr/share/zoneinfo/Asia/Bangkok /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# -----------------------------
# 3. CREATE COMPANY STRUCTURE
# -----------------------------
RUN mkdir -p /company_data/HR \
    /company_data/Engineering \
    /company_data/Finance

# -----------------------------
# 4. CREATE GROUPS
# -----------------------------
RUN groupadd hr && \
    groupadd engineering && \
    groupadd finance
#fix this
RUN chmod 755 /company_data
# -----------------------------
# 5. CREATE USERS
# -----------------------------
RUN useradd -m -g hr hr1 && \
    useradd -m -g engineering eng1 && \
    useradd -m -g finance fin1

# -----------------------------
# 6. SET PERMISSIONS
# -----------------------------
RUN chown -R :hr /company_data/HR && \
    chown -R :engineering /company_data/Engineering && \
    chown -R :finance /company_data/Finance && \
    chmod 770 /company_data/HR && \
    chmod 770 /company_data/Engineering && \
    chmod 770 /company_data/Finance

# -----------------------------
# 7. ADVANCED PERMISSIONS
# -----------------------------
RUN chmod g+s /company_data/HR /company_data/Engineering /company_data/Finance && \
    chmod +t /company_data/HR

# -----------------------------
# 8. SUDO CONFIGURATION
# -----------------------------
RUN useradd -m -G sudo eng_lead && \
    echo "eng_lead ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    echo "Defaults logfile=/var/log/sudo.log" >> /etc/sudoers

# -----------------------------
# 9. FILE LINKS
# -----------------------------
RUN touch /company_data/Engineering/project.txt && \
    ln /company_data/Engineering/project.txt /company_data/Engineering/project_hardlink && \
    ln -s /company_data/Engineering/project.txt /company_data/project_symlink

# -----------------------------
# 10. SECURITY AUDIT SCRIPT
# -----------------------------
RUN printf '%s\n' \
'#!/bin/bash' \
'echo "=== Security Audit ===" > /report.txt' \
'find /company_data -maxdepth 2 -exec ls -ld {} \; > /audit.log 2> /error.log' \
'awk "{print \$1, \$3, \$4, \$9}" /audit.log >> /report.txt' \
> /audit.sh && chmod +x /audit.sh

# -----------------------------
# 11. BACKUP SCRIPT
# -----------------------------
RUN echo '#!/bin/bash\ntar -czf /backup.tar.gz /company_data' > /backup.sh && \
    chmod +x /backup.sh

# -----------------------------
# 12. CRON JOB
# -----------------------------
RUN echo "* * * * * root /backup.sh" >> /etc/crontab

# -----------------------------
# 13. ONBOARDING FUNCTION
# -----------------------------
RUN echo 'onboard() { useradd -m -g $1 $2; echo "$2 added to $1"; }' >> /etc/bash.bashrc

# -----------------------------
# 14. LOGIN BANNER
# -----------------------------
RUN echo "Welcome to Company OS - Authorized Access Only" > /etc/motd

# -----------------------------
# 15. SELF-HEALING ENTRYPOINT
# -----------------------------
RUN printf '%s\n' \
'#!/bin/bash' \
'chown root:hr /company_data/HR' \
'chown root:engineering /company_data/Engineering' \
'chown root:finance /company_data/Finance' \
'chmod 770 /company_data/HR /company_data/Engineering /company_data/Finance' \
'chmod g+s /company_data/HR /company_data/Engineering /company_data/Finance' \
'chmod +t /company_data/HR' \
'service cron start' \
'/audit.sh' \
'echo "Permissions reset on startup"' \
'exec "$@"' \
> /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
