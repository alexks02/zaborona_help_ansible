#!/bin/sh

ansible-playbook -i provisioning/inventory -c local provisioning/playbook.yml
