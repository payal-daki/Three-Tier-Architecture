#!/bin/bash

# Update the package list and install MySQL
apt-get update
apt-get install -y mysql-server

# Secure MySQL installation (requires user interaction)
mysql_secure_installation <<EOF

Y
yourpassword
yourpassword
Y
Y
Y
Y
EOF

# Create a sample database and user
mysql -u root -pyourpassword -e "CREATE DATABASE sample_db;"
mysql -u root -pyourpassword -e "CREATE USER 'sample_user'@'%' IDENTIFIED BY 'userpassword';"
mysql -u root -pyourpassword -e "GRANT ALL PRIVILEGES ON sample_db.* TO 'sample_user'@'%';"
mysql -u root -pyourpassword -e "FLUSH PRIVILEGES;"
