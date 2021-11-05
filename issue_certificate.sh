#!/bin/bash

PATH=$PATH:"/root/.acme.sh"

# Issue the certificate using Apache mode
acme.sh --issue --apache \
        # -d karbonowy.pl -d www.karbonowy.pl \
        -d new.karbonowy.pl \
        --server letsencrypt

# Copy the certifcate files to the stable location and set Apache reload command
acme.sh --install-cert \
        # -d karbonowy.pl -d www.karbonowy.pl \
        -d new.karbonowy.pl \
        --cert-file /var/cert/karbonowy.pl/cert.pem \
        --key-file /var/cert/karbonowy.pl/key.pem \
        --fullchain-file /var/cert/karbonowy.pl/fullchain.pem \
        --reloadcmd "service apache2 force-reload"
