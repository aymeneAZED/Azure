#Installer apache2
echo "Install Apache2"
sudo su
apt update
apt-get install apache2 -y 
systemctl start apache 
apt-get install php libapache2-mod-php php-mysql
apt-get install php-mysql -y
#Install mariadb
echo "Install mariadb"
apt-get install mariadb-server -y

#Connexion Mariadb

echo "CREATE USER 'wordpress'@'%' IDENTIFIED BY 'Test';" | mysql -h piaze.mariadb.database.azure.com -u aymlo@piaze -p'@zeggaghPierret1234'
echo "CREATE DATABASE dbwordpress;" | mysql -h piaze.mariadb.database.azure.com -u aymlo@piaze -p'@zeggaghPierret1234'
echo "GRANT ALL PRIVILEGES ON wp.* TO 'dbwordpress'@'%';" | mysql -h piaze.mariadb.database.azure.com -u aymlo@piaze -p'@zeggaghPierret1234'
echo "GRANT ALL PRIVILEGES ON wp.* TO 'wordpress'@'%';" | mysql -h piaze.mariadb.database.azure.com -u aymlo@piaze -p'@zeggaghPierret1234'



#Install wordpress

cd /var/www
mkdir wp
cd wp
wget https://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
chmod -R  o+w wordpress/





touch /etc/apache2/sites-available/001-testsite.conf
echo "<VirtualHost *:80>
    ServerAdmin dbwordpress@piaze
    ServerName wordpress.lan
    ServerAlias www.wordpress.lan
    DocumentRoot /var/www/wp/wordpress
    <Directory /var/www/wp/wordpress>
                AllowOverride all
                Require all granted
     </Directory>
 </VirtualHost>" > /etc/apache2/sites-available/001-testsite.conf

a2dissite 000-default.conf
a2ensite 001-testsite.conf
systemctl reload apache2








            