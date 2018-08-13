#!/bin/sh

. provisioning/venv/bin/activate
ansible-playbook -vvv -i provisioning/inventory provisioning/playbook.yml
