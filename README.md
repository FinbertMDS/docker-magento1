# Docker compose for Magento 1.

## Build Docker Magento 1
1. Download Magento
    - Copy src magento to folder `src/magento1.tar.gz`, magento sample data to folder `src/magento-sample-data-1.9.2.4.tar.gz`.
    - Download magento by command line
        - Edit magento version and magento sample data version in file `.env`
            ```text
            MAGENTO_VERSION=1.9.3.10
            MAGENTO_SAMPLE_DATA_VERSION=1.9.2.4
            SAMPLE_DATA=1 # install magento with sample data
            MAGENTO_EDITION=CE # install magento edition is CE/EE
            ```
            ```bash
            ./bin/downloadMagento.sh
            ```
2. Build images
    ```bash
    ./bin/build.sh
    ```
3. Run service
    ```bash
    ./bin/run.sh #Run containers, show output to console
    ./bin/run.sh -d #Run containers in the background, print new container names
    ```
4. Provide permission edit for user `www-data` to in docker container folder `/var/www/html`
    ```bash
    ./bin/ssh.sh root
    ```
    ```bash
    chown -R www-data:www-data ./
    chmod -R 777 ./
    ```
5. Install magento 2
    ```bash
    ./bin/ssh.sh
    install_magento.sh 
    ```

## Stop service
```bash
./bin/stop.sh
```

## Remove service
```bash
./bin/remove.sh
```

## SSH
SSH to docker container with user: `root` or `www-data`. Default is `www-data`
```bash
./bin/ssh.sh user
```

### Note
- Docker: Apache2, Php5.6, Magento1, MariaDb 10.0, Phpmyadmin, Composer
    - Magento run at port: http - 9095 and https: 9096
    - Phpmyadmin run at port: 9097
    - Mariadb run at port: 3308
- Install nginx in host (nginx reverse proxy)
- Links:
    - Magento2: 
        - Fontend: https://magento1.com/
        - Backend: https://magento1.com/admin/ or https://magento1.com/index.php/admin/
        
            Username: admin
            
            Password: admin123
    - Phpmyadmin: http://phpmyadmin.magento1.com/
- Source:
    - Download Magento 1: http://pubfiles.nexcess.net/magento/ce-packages/
    - Download Magento 1 Sample data: https://sourceforge.net/projects/mageloads/