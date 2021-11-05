#!/bin/bash

service mysql start

service syslog-ng start

service postfix start

service memcached start

service cron start

exec apachectl -D FOREGROUND
