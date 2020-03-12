TOKEN="$(cat /var/www/x13allegro-token.txt)"
wget -O - http://karbonowy.pl/modules/x13allegro/sync.php?token=$TOKEN
