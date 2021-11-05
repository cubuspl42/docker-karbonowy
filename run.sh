set -u
docker run --name karbonowy -ti -p 80:80 -p 443:443 \
-v $PRESTASHOP_ROOT:/var/www/html \
-v $CERT_ROOT:/var/cert \
-v karbonowy-mysql:/var/lib/mysql \
-d \
--restart always \
karbonowy \
/bin/docker_run_karbonowy.sh
