!#/bin/bash
# free up disk space on /boot (to install new linux images)
dpkg -l linux-{image,headers}-[0-9]* | awk '/^ii/{ print }' | grep -v -e 4.13.0-37 | grep -e '[0-9]' | xargs sudo apt-get -y purge
