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

# Allow traversal (IMPORTANT)
RUN chmod 755 /company_data

# -----------------------------
# 4. CREATE GROUPS
# -----------------------------
RUN groupadd hr && \
    groupadd engineering && \
    groupadd finance

# -----------------------------
# 5. CREATE USERS
# -----------------------------
RUN useradd -m -g hr hr1 && \
    useradd -m -g engineering eng1 && \
    useradd -m -g finance fin1

# -----------------------------
# 6. SET PERMISSIONS (INITIAL)
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
RUN echo '#!/bin/bash\n\
ls -l /company_data > /audit.log 2> /error.log\n\
grep "^-r" /audit.log | awk "{print \$1, \$3}" > /report.txt' > /audit.sh && \
    chmod +x /audit.sh

# -----------------------------
# 11. BACKUP SCRIPT
# -----------------------------
RUN printf '#!/bin/bash\n\
tar -czf /backup.tar.gz /company_data\n' > /backup.sh && \
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
RUN printf '#!/bin/bash\n\
chmod 755 /company_data\n\
chmod 770 /company_data/HR\n\
chmod 770 /company_data/Engineering\n\
chmod 770 /company_data/Finance\n\
echo "Permissions reset on startup"\n\
exec "$@"\n' > /entrypoint.sh && \
    chmod +x /entrypoint.sh
    
ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]