FROM alpine:3.22

# Dependencies
COPY packages.txt /tmp/packages.txt
RUN apk update && apk add --no-cache $(awk '{print $1}' /tmp/packages.txt)
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt
COPY requirements.yml /tmp/requirements.yml
RUN ansible-galaxy collection install -r /tmp/requirements.yml --force

# Environment Variables
ENV REQUIRED_VARS="SWITCH_HOST SWITCH_USERNAME SWITCH_PASSWORD SFTP_HOST SFTP_USERNAME SFTP_PASSWORD SFTP_PATH PUSHOVER_USER_KEY PUSHOVER_APP_TOKEN"
ENV CRON_SCHEDULE="0 0 * * * (daily)"
ENV SFTP_PORT=22

# Start App
WORKDIR /app
COPY playbook.yml .
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
VOLUME /var/log/cron
CMD ["/docker-entrypoint.sh"]
