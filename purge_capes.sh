#!/bin/bash

# warn user
read -p "
WARNING: pressing enter now will attempt to remove all customization
         performed by the deploy script.  Press Ctrl-C now to abort." VAR

# stop all the services
sudo systemctl stop mattermost.service
sudo systemctl stop filebeat.service
sudo systemctl stop metricbeat.service
sudo systemctl stop heartbeat.service
sudo systemctl stop nginx.service
sudo systemctl stop murmur.service
sudo systemctl stop thehive.service
sudo systemctl stop hackmd.service
sudo systemctl stop gitea.service
sudo systemctl stop cortex.service
sudo systemctl stop kibana.service
sudo systemctl stop elasticsearch.service

# disable all the services
sudo systemctl disable mattermost.service
sudo systemctl disable filebeat.service
sudo systemctl disable metricbeat.service
sudo systemctl disable heartbeat.service
sudo systemctl disable nginx.service
sudo systemctl disable murmur.service
sudo systemctl disable thehive.service
sudo systemctl disable hackmd.service
sudo systemctl disable gitea.service
sudo systemctl disable cortex.service
sudo systemctl disable kibana.service
sudo systemctl disable elasticsearch.service

# TODO: need to rewrite conf file with a D or R?
#sudo systemd-tmpfiles --create /etc/tmpfiles.d/murmur.conf

#sudo firewall-cmd --remove-port=80/tcp --remove-port=3000/tcp --remove-port=4000/tcp --remove-port=5000/tcp --remove-port=5601/tcp --remove-port=9000/tcp --remove-port=9001/tcp --remove-port=7000/tcp --remove-port=7000/udp --permanent
#sudo firewall-cmd --reload

sudo yum erase -y kibana-5.6.5 metricbeat-5.6.5 filebeat-5.6.5 heartbeat-5.6.5
sudo rm -f -r /etc/filebeat/ /etc/heartbeat/ /etc/metricbeat/ /etc/kibana/

sudo rm -f /usr/share/nginx/html/cyberchef.htm

sudo yum erase -y nginx httpd-tools
sudo rm -f -r /usr/share/nginx/html/*
sudo rm -f -r /etc/nginx/

sudo yum erase -y thehive cortex
sudo rm -f /etc/thehive/application.conf* /etc/cortex/application.conf*
sudo rmdir /etc/cortex/ /etc/thehive/ /opt/cortex/* /opt/cortex/ /opt/thehive/* /opt/thehive/

sudo yum erase -y elasticsearch-5.6.0
sudo rm -f /etc/elasticsearch/elasticsearch.yml*

sudo rm -f /etc/systemd/system/gitea.service*
sudo rm -f -r /opt/gitea
mysql -uroot -e "DROP DATABASE gitea;"
sudo yum erase -y wandisco-git-release-7-2

mysql -uroot -e "DROP DATABASE hackmd;"
sudo rm -f /etc/systemd/system/hackmd.service*
sudo rm -f -r /opt/hackmd

mysql -uroot -e "DROP DATABASE mattermost;"
sudo rm -f /etc/systemd/system/mattermost.service*
sudo rmdir /opt/mattermost/data /opt/mattermost/

sudo rm -f /etc/tmpfiles.d/murmur.conf* /etc/systemd/system/murmur.service* /etc/logrotate.d/murmur* /etc/murmur.ini*
sudo rm -f -r /opt/murmur /var/log/murmur

echo MariaDB has not been uninstalled.
echo dependencies of the main packages have not been uninstalled.
