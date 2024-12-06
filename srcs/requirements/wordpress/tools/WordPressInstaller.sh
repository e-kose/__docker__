#!/bin/sh
set -e

# Docker Secrets'tan kullanıcı adı ve şifreyi al
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)

# Eğer wp-config.php dosyası mevcutsa, WordPress zaten indirildi demektir.
if [ -f ./wp-config.php ]; then
    echo "WordPress already downloaded"
else
    echo "WordPress Downloading"

    # Daha önce indirilen dosyaları temizleyin (eğer varsa)
    rm -rf ./wp-admin ./wp-content ./wp-includes

    # WordPress'i indir
    wget -q http://wordpress.org/latest.tar.gz

    # Eğer indirme başarısız olursa, hata mesajı veririz
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download WordPress"
        exit 1
    fi

    # İndirilen dosyayı aç
    tar xfz latest.tar.gz
    mv wordpress/* .
    rm -rf latest.tar.gz
    rm -rf wordpress

    # wp-config.php dosyasındaki yer tutucuları değiştirme
    sed -i "s/username_here/$DB_USER/g" wp-config-sample.php
    sed -i "s/password_here/$DB_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$WORDPRESS_DB_HOST/g" wp-config-sample.php
    sed -i "s/database_name_here/$WORDPRESS_DB_NAME/g" wp-config-sample.php

    # wp-config-sample.php dosyasını wp-config.php olarak kopyala
    cp wp-config-sample.php wp-config.php

    echo "WordPress downloaded and wp-config.php created."
fi
exec "$@"