FROM leafney/ubuntu-mysql

ENV DEBIAN_FRONTEND="noninteractive"
ENV APACHE_DOCUMENT_ROOT="/var/www/html/ilias/"
ENV MYSQL_ROOT_PWD="mysql"

RUN apt-get update \
    && apt-get install -y apache2 php7.0 wget less htop git php7.0-fpm curl \
    && apt-get install -y libapache2-mod-php7.0 php7.0-gd php7.0-mysql php7.0-mbstring php-xml nodejs

RUN cd /var/www/html \
    && git clone https://github.com/ILIAS-eLearning/ILIAS.git ilias \
    && cd ilias \
    && git checkout release_5-4 \
    && chown www-data:www-data /var/www/html/ilias -R \
    && sed -i 's!/var/www/html!/var/www/html/ilias/!g' /etc/apache2/sites-enabled/000-default.conf

RUN echo "sql_mode=IGNORE_SPACE,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION" >> /etc/mysql/my.cnf

RUN service mysql start $ sleep 10 \
    && mysql -u root -pmysql -e "CREATE DATABASE ilias CHARACTER SET utf8 COLLATE utf8_general_ci; CREATE USER 'ilias'@'localhost' IDENTIFIED BY 'password'; GRANT LOCK TABLES on *.* TO 'ilias@localhost'; GRANT ALL PRIVILEGES ON ilias.* TO 'ilias'@'localhost'; FLUSH PRIVILEGES;"

RUN apt-get install -y zip unzip imagemagick openjdk-8-jdk phantomjs

RUN sed -i 's!sleep 5!sleep 5; /usr/sbin/apachectl -D FOREGROUND \&!g' /root/startup.sh

EXPOSE 80
