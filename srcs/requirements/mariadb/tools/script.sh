#!/bin/sh
set -e

# Docker secrets dosyasını oku
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)

# MySQL servisini başlat
service mariadb start
sleep 5
# MySQL komutlarını çalıştır
mysql -uroot -p"${DB_ROOT_PASSWORD}" <<-EOSQL
    CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
EOSQL

# MySQL servisini yeniden başlat
service mariadb restart
sleep 7
# MySQL servisini ön planda çalıştır
exec mysqld
