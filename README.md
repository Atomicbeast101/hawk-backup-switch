# HawkBackup - HP Switch Config Backup

Docker-based service that leverages Ansible to perform backups for HP switches (2x HPE Aruba 2530-24G J9773A) in my homelab.

## Requirements

* HP switch that uses Aruba OS
* Account with access to `show running-config`

## How it Works

Whenever the cron schedule hits, it runs an Ansible playbook that does the following:
1) Create `/app/.downloads` folder.
2) Execute `show running-config` in switch CLI & extract data from it to a file in `/app/.downloads` folder.
3) Uploads that config file to SFTP endpoint.
4) Removes the config file from `/app/.downloads`.

If any of the tasks above fails, a Pushover notification will be sent stating that the backup failed for a specific firewall (by hostname).

## Setup - Docker

Here's an example of how to run this application in Docker:

```bash
docker run \
    -e SWITCH_HOST=switch.example.com \
    -e SWITCH_USERNAME=admin \
    -e SWITCH_PASSWORD=<password> \
    -e SFTP_HOST=sftp.example.com \
    -e SFTP_USERNAME=backup \
    -e SFTP_PASSWORD=<password> \
    -e SFTP_PATH="/path/to/directory" \
    -e PUSHOVER_USER_KEY=<user_key> \
    -e PUSHOVER_APP_TOKEN=<user_password> \
    ghcr.io/atomicbeast101/hawk-backup-switch:latest
```

More details on the environment variables can be found below.

## Environment Variables

| Environment Variable | Description | Default |
| :------- | :------ | :-------: |
| CRON_SCHEDULE | Interval to run backups (defaults to daily). | 0 0 * * * |
| SWITCH_HOST | FQDN/IP address of HP switch to perform config backup. | N/A |
| SWITCH_USERNAME | Username for HP switch SSH access. | N/A |
| SWITCH_PASSWORD | Password for HP switch access. | N/A |
| SFTP_HOST | FQDN/IP address of SFTP server to send downloaded config file to. | N/A |
| SFTP_PORT | Port of SFTP server. | 22 |
| SFTP_USERNAME | Username for SFTP server. | N/A |
| SFTP_PASSWORD | Password for SFTP server. | N/A |
| SFTP_PATH | Destination path in SFTP server to store config file in. | N/A |
| PUSHOVER_USER_KEY | User key for Pushover notifications. Gets sent out for failed backups. | N/A |
| PUSHOVER_APP_TOKEN | App token for Pushover notifications. Gets sent out for failed backups. | N/A |
