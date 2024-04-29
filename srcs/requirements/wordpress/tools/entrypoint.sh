#!/bin/bash

service php7.3-fpm start

#--- check if all required environment variables are set ---#
if [ -z "$MYSQL_DATABASE" ] || [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$DOMAIN_NAME" ] || [ -z "$WP_TITLE" ] || [ -z "$WP_ADMIN" ] || [ -z "$WP_PASSWORD" ] || [ -z "$WP_EMAIL" ] || [ -z "$WP_USER" ] || [ -z "$WP_USER_EMAIL" ] || [ -z "$WP_USER_PASSWORD" ] || [ -z "$MYSQL_HOST"]; then
	echo "Error: One or more environment variables are undefined. Check that all credentials are provided."
	exit 1
fi

#--- ensure admin username does not contain 'admin' ---#
if [[ "$WP_ADMIN" == *"admin"* ]]; then
	echo "Error: WP_ADMIN variable contains 'admin'. Please use a more secure admin username."
	exit 1
fi

#--- check if WordPress is already configured ---#
if [ ! -f /var/www/html/wp-config.php ]; then
	echo "Setting up WordPress..."
	wp core download --path=/var/www/html --allow-root
	sleep 10
	wp config create --dbname="${MYSQL_DATABASE}" --dbuser="${MYSQL_USER}" --dbpass="${MYSQL_PASSWORD}" --dbhost="${MYSQL_HOST}" --allow-root
	wp core install --url="${DOMAIN_NAME}" --title="${WP_TITLE}" --admin_user="${WP_ADMIN}" --admin_password="${WP_PASSWORD}" --admin_email="${WP_EMAIL}" --skip-email --allow-root
	wp user create "${WP_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --role=author --allow-root
else
	echo "WordPress is already configured."
fi

service php7.3-fpm stop

#--- start PHP-FPM in foreground mode ---#
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm7.3 -F

#--- handling unexpected script termination ---#
echo "Unexpected script exit. Check PHP-FPM logs for errors."
exit 1