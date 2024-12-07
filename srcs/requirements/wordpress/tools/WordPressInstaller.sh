#!/bin/sh
set -e

if [ -f ./wp-config.php ]; then
    echo "WordPress already downloaded"
else
    echo "WordPress Downloading"

    rm -rf ./wp-admin ./wp-content ./wp-includes

    wget -q http://wordpress.org/latest.tar.gz

    if [ $? -ne 0 ]; then
        echo "Error: Failed to download WordPress"
        exit 1
    fi

    tar xfz latest.tar.gz
    mv wordpress/* .
    rm -rf latest.tar.gz
    rm -rf wordpress

    echo "WordPress downloaded and wp-config.php created."
fi
exec "$@"