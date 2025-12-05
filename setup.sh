#!/bin/bash

# Create virtual environment if not done
python3 -m venv .venv

# Installed required modules for ansible playbooks
source .venv/bin/activate
PYTHON_SITE_PACKAGES=`python -c 'import site; print(site.getsitepackages()[0])'`
.venv/bin/python3 -m pip install -r requirements.txt
.venv/bin/python3 -m pip install --no-binary ansible-pylibssh # Install additional package for connecting to HP switches using ansible collection - skips needing CC language which seems to not work on alpine regardless of installing dependencies for it.
.venv/bin/ansible-galaxy collection install -p $PYTHON_SITE_PACKAGES/ansible_collections -r requirements.yml --force
deactivate
