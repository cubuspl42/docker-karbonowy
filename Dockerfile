FROM prestashop/prestashop:1.7
SHELL ["/bin/bash", "-c"]

RUN apt-get update

# Apache
COPY ./default-ssl.conf /etc/apache2/sites-available/
RUN service apache2 start && \
    a2enmod ssl && \
    a2ensite default-ssl

# MySQL
COPY mysql_secure_installation.sql /tmp/
COPY create_database.sql /tmp/
RUN apt-get install -y mysql-server && \
    service mysql start && \
    mysql -u root < /tmp/mysql_secure_installation.sql && \
    mysql -u root < /tmp/create_database.sql

# PHP
COPY 99-karbonowy.ini /usr/local/etc/php/conf.d/

# Postfix
RUN debconf-set-selections <<< "postfix postfix/mailname string karbonowy.pl" && \
    debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'" && \
    apt-get install -y postfix

# Utils
RUN apt-get install -y less vim

COPY log.cnf /etc/mysql/conf.d/

COPY docker_run_karbonowy.sh /tmp/
CMD /tmp/docker_run_karbonowy.sh
