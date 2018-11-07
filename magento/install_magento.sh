#!/usr/bin/env bash

chmod -R 777 /var/www/html
php -f /var/www/html/install.php -- --license_agreement_accepted yes \
    --locale $MAGENTO_LOCALE --timezone $MAGENTO_TIMEZONE --default_currency $MAGENTO_DEFAULT_CURRENCY \
    --db_host $MYSQL_HOST --db_name $MYSQL_DATABASE --db_user $MYSQL_USER --db_pass $MYSQL_PASSWORD \
    --url $MAGENTO_URL --use_rewrites yes \
    --use_secure yes --secure_base_url $MAGENTO_SECURE_URL --use_secure_admin yes \
    --admin_firstname $MAGENTO_ADMIN_FIRSTNAME --admin_lastname $MAGENTO_ADMIN_LASTNAME \
    --admin_email $MAGENTO_ADMIN_EMAIL --admin_username $MAGENTO_ADMIN_USERNAME \
    --admin_password $MAGENTO_ADMIN_PASSWORD