#!/usr/bin/env bash

source .env

# init folder mount docker
mkdir -p src
mkdir -p data/mysql

# remove all persist data
sudo rm -rf data/mysql/*
sudo rm -rf src/*
sudo rm -rf src/.*
rm data/prepare_data/magento1.sql
sudo rm /etc/nginx/sites-available/nginx-magento1-docker*
sudo rm /etc/nginx/sites-enabled/nginx-magento1-docker*

if [[ ! -f magento/magento1.tar.gz ]]; then
  echo "Please place file magento.tar.gz at folder magento"
  exit
fi

tar xvf magento/magento1.tar.gz -C src
rsync -av src/magento/* src
rm -rf src/magento

if [[ -f magento/magento-sample-data-${MAGENTO_SAMPLE_DATA_VERSION}.tar.gz ]]; then
    tar xvf magento/magento-sample-data-${MAGENTO_SAMPLE_DATA_VERSION}.tar.gz -C src
    rsync -av src/magento-sample-data-${MAGENTO_SAMPLE_DATA_VERSION}/* src
    rm -rf src/magento-sample-data-${MAGENTO_SAMPLE_DATA_VERSION}
fi

cp data/prepare_data/magento_sample_data_for_${MAGENTO_SAMPLE_DATA_VERSION}.sql data/prepare_data/magento1.sql

# install nginx
sudo apt update
sudo apt install nginx -y
sudo ufw allow 'Nginx HTTP'
sudo service nginx restart

# init nginx reverse proxy
sudo mkdir -p /etc/nginx/ssl
sudo cp magento/server.crt /etc/nginx/ssl/magento1_ssl.crt
sudo cp magento/server.key /etc/nginx/ssl/magento1_ssl.key

NGINX_CONF=nginx-magento1-docker
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