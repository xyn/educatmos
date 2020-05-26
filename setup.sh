#!/bin/bash

sudo apt update
sudo apt install -y git ansible

sudo ansible-pull -U https://github.com/slave2anubis/educatm.git -C master