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







##!/bin/bash
    #sudo yum update -y && sudo yum upgrade -y
    #sudo yum install docker -y
    #sudo systemctl enable docker.service
    #sudo service docker start
    #sudo docker pull wordpress 
    #sudo mkdir wordpress
    #cd wordpress
    #sudo docker pull wordpress
    #sudo docker pull mysql
    #sudo docker run --name wordpressdb -e mysql_root_password=aymene1234 -e mysql_database= mydatabase -d mysql:5.7.29
    #Sudo docker run -e wordpress_db_password= aymene1234 -d --name wordpress --link wordpressdb:mysql wordpress
    #sudo docker run -e wordpress_db_host= mysqldbinstance.Endpoint.Address:3306 -e wordpress_db_user=aymene -e wordpress_db_password=aymene1234 -e wordpress_db_name=mydatabase -p 80:80 -d --name wordpress --link wordpressdb:mysql -p 80:80 -v "$PWD/":/var/www/html wordpress







    #!/bin/bash
            sudo apt update -y && sudo apt upgrade -y
            sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
            curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
            sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
            sudo apt update -y
            apt-cache policy docker-ce
            sudo apt install docker-ce -y
            sudo docker pull mysql:5.7.29
            sudo apt install mysql-client-core-8.0 -y
            sudo docker run -e MYSQL_ROOT_PASSWORD=aymene1234 -e MYSQL_USER=aymene -e MYSQL_PASSWORD=aymene1234 -e MYSQL_DATABASE=mydatabase -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mysql:5.7.29
            sudo docker pull wordpress:latest
            