# Untested
acme.sh --issue --standalone -d karbonowy.pl -d www.karbonowy.pl
acme.sh --install-cert -d karbonowy.pl -d www.karbonowy.pl \
    --cert-file /root/cert/karbonowy.pl/cert.pem \
    --key-file /root/cert/karbonowy.pl/key.pem \
    --fullchain-file /root/cert/karbonowy.pl/fullchain.pem