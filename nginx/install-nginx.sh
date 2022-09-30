#!/bin/bash

# test what os we are running
if [ -f /etc/redhat-release ]; then
    OS=centos
    VER=$(cat /etc/redhat-release | sed 's/[^0-9.]*\([0-9.]\).*/\1/')
elif [ -f /etc/debian_version ]; then
    OS=debian
    VER=$(cat /etc/debian_version | sed 's/[^0-9.]*\([0-9.]\).*/\1/')
else
    OS=$(uname -s)
    VER=$(uname -r)
fi

# if OS is centos, run the following
if [ "$OS" = "centos" ]; then
    # install epel repo
    yum install -y epel-release
    # install nginx
    yum install -y nginx
    # install yum-utils
    yum install -y yum-utils
    # copy nginx.repo to /etc/yum.repos.d/
    cp nginx.repo /etc/yum.repos.d/
    # enable nginx-mainline
    yum-config-manager --enable nginx-mainline
    # install nginx
    yum install -y nginx
    # create /data/www
    mkdir -p /data/www
    # copy index.html to /data/www
    cp index.html /data/www
    # create /data/lists
    mkdir  /data/lists
    # create /data/scripts
    mkdir /data/scripts
    # copy AWS-Service-IPs.sh to /data/scripts
    cp ./Scripts/AWS-Service-IPs.sh /data/scripts/AWS-Service-IPs.sh
    # run AWS-Service-IPs.sh
    bash /data/scripts/AWS-Service-IPs.sh
    # create a symlink to AWS-Service-IPs.sh in /etc/cron.daily
    ln -s /data/scripts/AWS-Service-IPs.sh /etc/cron.daily/AWS-Service-IPs.sh
    # copy dynamic-lists.nginx to /etc/nginx/sites-available/dynamic-lists
    cp dynamic-lists.nginx /etc/nginx/sites-available/dynamic-lists
    # create a symlink to dynamic-lists.nginx in /etc/nginx/sites-enabled
    ln -s /etc/nginx/sites-available/dynamic-lists /etc/nginx/sites-enabled/dynamic-lists
    # remove default nginx config
    rm /etc/nginx/sites-enabled/default
    # restart nginx
    systemctl restart nginx
fi

# if OS is debian, run the following
if [ "$OS" = "debian" ]; then
    # update
    apt-get update && apt-get upgrade -y
    # install nginx
    apt-get install -y nginx
    # create /data/www
    mkdir -p /data/www
    # copy index.html to /data/www
    cp index.html /data/www
    # create /data/lists
    mkdir  /data/lists
    # create /data/scripts
    mkdir /data/scripts
    # copy AWS-Service-IPs.sh to /data/scripts
    cp ./Scripts/AWS-Service-IPs.sh /data/scripts/AWS-Service-IPs.sh
    # run AWS-Service-IPs.sh
    bash /data/scripts/AWS-Service-IPs.sh
    # create a symlink to AWS-Service-IPs.sh in /etc/cron.daily
    ln -s /data/scripts/AWS-Service-IPs.sh /etc/cron.daily/AWS-Service-IPs.sh
    # copy dynamic-lists.nginx to /etc/nginx/sites-available/dynamic-lists
    cp dynamic-lists.nginx /etc/nginx/sites-available/dynamic-lists
    # create a symlink to dynamic-lists.nginx in /etc/nginx/sites-enabled
    ln -s /etc/nginx/sites-available/dynamic-lists /etc/nginx/sites-enabled/dynamic-lists
    # remove default nginx config
    rm /etc/nginx/sites-enabled/default
    # restart nginx
    systemctl restart nginx
fi