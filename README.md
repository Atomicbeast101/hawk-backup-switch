# HawkBackup - HP Switch Config Backup

Docker-based service that leverages Ansible to perform backups for HP switches (2x HPE Aruba 2530-24G J9773A) in my homelab.

## How it Works

TODO

## Setup

TODO

## Environment Variables

| Environment Variable | Description | Default |
| :------- | :------ | :-------: |
| CRON_SCHEDULE | Interval to run backups. | 0 0 * * * (daily) |
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
