FROM ubuntu:26.04

# Dependencies
COPY packages.txt /tmp/packages.txt
RUN apt update && apt install --no-install-recommends $(cat /tmp/packages.txt)

# Environment Variables
ENV REQUIRED_VARS="SWITCH_HOST SWITCH_USERNAME SWITCH_PASSWORD SFTP_HOST SFTP_USERNAME SFTP_PASSWORD SFTP_PATH PUSHOVER_USER_KEY PUSHOVER_APP_TOKEN"
ENV CRON_SCHEDULE="0 0 * * *"
ENV SFTP_PORT=22

# Start App
WORKDIR /app
COPY requirements.txt .
COPY requirements.yml .
COPY playbook.yml .
COPY *.sh .
RUN chmod +x /app/*.sh
VOLUME /var/log/cron
CMD ["./docker-entrypoint.sh"]