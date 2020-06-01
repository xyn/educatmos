#!/bin/bash

while :; do
        wget -q --spider http://google.com

        if [ $? -eq 0 ]; then
                /usr/bin/ansible-pull -o -U https://github.com/EducaTM/educatmos.git -C master > /home/ansible/last_log
                break
        fi
        sleep 10
done
