#!/usr/bin/env bash

# init folder mount docker
mkdir -p src
mkdir -p data/mysql

# remove all persist data
sudo rm -rf data/mysql/*
sudo rm -rf src/*
sudo rm -rf src/.*
rm data/prepare_data/magento.sql
sudo rm /etc/nginx/sites-available/nginx-magento-docker*
sudo rm /etc/nginx/sites-enabled/nginx-magento-docker*

if [[ ! -f magento/magento.tar.gz ]]; then
  echo "Please place file magento.tar.gz at folder magento"
  exit
fi

if [[ ! -f src/magento.tar.gz ]]; then
    sudo cp magento/magento.tar.gz src/
    cd src
    sudo tar xvf magento.tar.gz
    cd ..
fi

source .env
cp data/prepare_data/magento_sample_data_for_$MAGENTO_VERSION.sql data/prepare_data/magento.sql

# install nginx
sudo apt update
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo service nginx restart

# init nginx reverse proxy
sudo mkdir -p /etc/nginx/ssl
sudo cp magento/server.crt /etc/nginx/ssl/magento_ssl.crt
sudo cp magento/server.key /etc/nginx/ssl/magento_ssl.key

NGINX_CONF=nginx-magento-docker
sudo cp nginx/${NGINX_CONF} /etc/nginx/sites-available
if [[ ! -f /etc/nginx/sites-available/${NGINX_CONF} ]]; then
  echo "file site available not exist"
  exit
fi
if [[ ! -f /etc/nginx/sites-enabled/${NGINX_CONF} ]]; then
  sudo ln -s /etc/nginx/sites-available/${NGINX_CONF} /etc/nginx/sites-enabled/
fi
sudo service nginx restart

# stop then remove all container start by docker composer
 docker-compose build