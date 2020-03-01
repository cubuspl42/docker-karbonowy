CREATE DATABASE prestashop;
CREATE USER IF NOT EXISTS 'prestashop'@'localhost' IDENTIFIED BY 'prestashop';
GRANT ALL PRIVILEGES ON prestashop.* TO 'prestashop'@'localhost';
FLUSH PRIVILEGES;