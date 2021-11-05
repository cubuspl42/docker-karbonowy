#!/usr/bin/php
<?php
$argc == 2 or die('Usage: prestashop_set_domain <domain>');
include 'config/settings.inc.php';

$link = mysql_connect('localhost', _DB_USER_, _DB_PASSWD_) or die('Could not connect: ' . mysql_error());
print('Connected successfully'.PHP_EOL);
mysql_select_db(_DB_NAME_) or die('Could not select database: ' . mysql_error() . PHP_EOL);
$DB_NAME = _DB_NAME_;

$query = <<<SQL
UPDATE  `$DB_NAME`.`ps_shop_url` SET  `domain` =  '$argv[1]', `domain_ssl` =  '$argv[1]' WHERE  `ps_shop_url`.`id_shop_url` =1;
SQL;
print($query.PHP_EOL);
$result = mysql_query($query) or die('Query failed: ' . mysql_error() . PHP_EOL);

$query = <<<SQL
UPDATE  `$DB_NAME`.`ps_configuration` SET  `value` =  '$argv[1]' WHERE  `ps_configuration`.`name` ='PS_SHOP_DOMAIN';
SQL;
print($query.PHP_EOL);
$result = mysql_query($query) or die('Query failed: ' . mysql_error() . PHP_EOL);

$query = <<<SQL
UPDATE  `$DB_NAME`.`ps_configuration` SET  `value` =  '$argv[1]' WHERE  `ps_configuration`.`name` ='PS_SHOP_DOMAIN_SSL';
SQL;
print($query.PHP_EOL);
$result = mysql_query($query) or die('Query failed: ' . mysql_error() . PHP_EOL);

mysql_close($link);
?>
