FROM prestashop/prestashop:1.6
SHELL ["/bin/bash", "-c"]

RUN apt-get update

# Configure Postfix installation
RUN debconf-set-selections <<< "postfix postfix/mailname string karbonowy.pl" && \
    debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"

# Install APT dependencies
RUN apt-get install -y \
            # MySQL
            default-mysql-server \
            # Postfix
            syslog-ng postfix \
            # memcached
            memcached libmemcached-tools \
            # utils
            less vim \
            # cron
            cron

# Install IonCube
RUN curl -fSL 'http://downloads3.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz' -o /tmp/ioncube.tar.gz && \
    mkdir -p /tmp/ioncube && \
    tar -xf /tmp/ioncube.tar.gz -C /tmp/ioncube --strip-components=1 && \
    rm /tmp/ioncube.tar.gz && \
    mv /tmp/ioncube/ioncube_loader_lin_7.3.so /var/www/ && \
    rm -r /tmp/ioncube

## Configure Apache
COPY ./default-ssl.conf /etc/apache2/sites-available/
RUN service apache2 start && \
    a2enmod ssl && \
    a2ensite default-ssl

# Configure MySQL
COPY mysql_secure_installation.sql /tmp/
COPY create_database.sql /tmp/
RUN service mysql start && \
    mysql -u root < /tmp/mysql_secure_installation.sql && \
    mysql -u root < /tmp/create_database.sql

# Configure PHP
COPY 99-karbonowy.ini /usr/local/etc/php/conf.d/

# Configure Allegro sync
COPY x13allegro-sync.sh /bin/
COPY x13allegro.cron /etc/cron.d/x13allegro.cron
RUN chmod 0644 /etc/cron.d/x13allegro.cron && \
    crontab /etc/cron.d/x13allegro.cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Initialize MySQL log
COPY log.cnf /etc/mysql/conf.d/

# SSL certificates management
RUN curl https://get.acme.sh | sh

COPY issue_certificate.sh /bin/

# root user shell configuration
COPY bashrc.bash /root/.bashrc

# Start-up script
COPY start.sh /root/bin/
