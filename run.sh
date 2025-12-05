#!/bin/bash

# Run ansible playbook
echo "Performing backup..."
PYTHON_SITE_PACKAGES=`python -c 'import site; print(site.getsitepackages()[0])'`
export ANSIBLE_COLLECTIONS_PATH=$PYTHON_SITE_PACKAGES/ansible_collections
export NETWORK_GROUP_MODULES=arubaoss
.venv/bin/ansible-playbook playbook.yml -i $SWITCH_HOST,
echo "Backup completed!"
