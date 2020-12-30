#!/bin/bash

sudo apt update
sudo apt install -y git ansible

sudo ansible-pull -U https://github.com/xyn/educatmos.git -C development

sudo rm /etc/xdg/autostart/piwiz.desktop

./install_zoom.sh
