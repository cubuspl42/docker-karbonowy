FROM prestashop/prestashop:1.7

RUN apt-get update

# Apache
COPY ./default-ssl.conf /etc/apache2/sites-available/
RUN service apache2 start && \
    a2enmod ssl && \
    a2ensite default-ssl

# MySQL
COPY mysql_secure_installation.sql /tmp/
COPY create_database.sql /tmp/
COPY data/prestashop.sql /tmp/
RUN apt-get install -y mysql-server && \
    service mysql start && \
    mysql -u root < /tmp/mysql_secure_installation.sql && \
    mysql -u root < /tmp/create_database.sql

# PHP
COPY 99-karbonowy.ini /usr/local/etc/php/conf.d/

# Utils
RUN apt-get install -y less vim

COPY docker_run_karbonowy.sh /tmp/
CMD /tmp/docker_run_karbonowy.sh
