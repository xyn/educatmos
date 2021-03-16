#!/bin/bash

while :; do
        wget -q --spider http://google.com

        if [ $? -eq 0 ]; then
                /usr/bin/ansible-pull -o -U https://github.com/xyn/educatmos.git -C update_test > /home/ansible/last_log
                /usr/bin/python3 /home/ansible/stats/stats.py
		sudo su -c "[ $(uname -m) == "armv7l" ] && cat /dev/null > /var/log/wtmp"
                break
        fi
        sleep 10
done
