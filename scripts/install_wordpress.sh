#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apache2 php php-mysql mysql-client

# Start and enable Apache2
sudo systemctl start apache2
sudo systemctl enable apache2

# Download and configure WordPress
cd /tmp
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xzf latest.tar.gz
sudo cp -r wordpress/* /var/www/html/
sudo rm -rf wordpress latest.tar.gz

# Set correct permissions
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configure wp-config.php
sudo cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

# Update WordPress configuration
sudo sed -i "s/database_name_here/${db_name}/" /var/www/html/wp-config.php
sudo sed -i "s/username_here/${db_username}/" /var/www/html/wp-config.php
sudo sed -i "s/password_here/${db_password}/" /var/www/html/wp-config.php
sudo sed -i "s/localhost/${db_endpoint}/" /var/www/html/wp-config.php

# Remove default Apache index.html
sudo rm -f /var/www/html/index.html

# Add heath endpoint for alb
echo "ok" | sudo tee /var/www/html/health.html

# Restart Apache2
sudo systemctl restart apache2