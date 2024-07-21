#!/bin/bash

# Update the package list and install Apache
apt-get update
apt-get install -y apache2

# Enable and start Apache service
systemctl enable apache2
systemctl start apache2

# Add a sample HTML file
echo "<html><body><h1>Welcome to the Web Tier!</h1></body></html>" > /var/www/html/index.html

# Optional: Install other necessary packages or deploy application files
