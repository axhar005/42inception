#!/bin/bash

#--- change ownership of the MySQL data directory ---#
chown -R mysql:mysql /var/lib/mysql

#--- initialize the database directory ---#
mysql_install_db --datadir=/var/lib/mysql --user=mysql --skip-test-db >> /dev/null

#--- prepare SQL commands to setup initial databases and users ---#
echo "FLUSH PRIVILEGES;" > tmp.sql
echo "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" >> tmp.sql
echo "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" >> tmp.sql
echo "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';" >> tmp.sql
echo "ALTER USER \`root\`@\`localhost\` IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" >> tmp.sql
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;" >> tmp.sql
echo "FLUSH PRIVILEGES;" >> tmp.sql

#--- execute the SQL commands ---#
mysqld --user=mysql --bootstrap < tmp.sql

#--- cleanup temporary SQL file ---#
rm -f tmp.sql

#--- start MariaDB server in the foreground ---#
exec mysqld_safe
