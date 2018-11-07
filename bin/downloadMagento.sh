#!/usr/bin/env bash

source .env

if [[ ! ${MAGENTO_EDITION} = 'CE' ]]; then
    exit
fi

MAGENTO_DOWNLOAD_URL='http://pubfiles.nexcess.net/magento/ce-packages/magento-'${MAGENTO_VERSION}'.tar.gz'
MAGENTO_SAMPLE_DATA_DOWNLOAD_URL='https://nchc.dl.sourceforge.net/project/mageloads/assets/'${MAGENTO_SAMPLE_DATA_VERSION}'/magento-sample-data-'${MAGENTO_SAMPLE_DATA_VERSION}'.tar.gz'

if [[ ${MAGENTO_SAMPLE_DATA_VERSION} = '1.9.2.4' ]]; then
    MAGENTO_SAMPLE_DATA_DOWNLOAD_URL='https://nchc.dl.sourceforge.net/project/mageloads/assets/1.9.2.4/magento-sample-data-1.9.2.4-fix.tar.gz'
fi

MAGENTO_FILENAME='magento/magento1.tar.gz'
MAGENTO_SAMPLE_FILENAME='magento/magento-sample-data-'${MAGENTO_SAMPLE_DATA_VERSION}'.tar.gz'
if [[ ! -f  ${MAGENTO_FILENAME} ]]; then
    wget -O ${MAGENTO_FILENAME} ${MAGENTO_DOWNLOAD_URL}
fi
if [[ ! -f  ${MAGENTO_SAMPLE_FILENAME} ]]; then
    if [[ ${SAMPLE_DATA} = '1' ]]; then
            wget -O ${MAGENTO_SAMPLE_FILENAME} ${MAGENTO_SAMPLE_DATA_DOWNLOAD_URL}
    fi
fi