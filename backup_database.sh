# Untested
BACKUP_BASE_NAME="prestashop-backup-$(date +%F-%T)"
BACKUP_SQL_PATH="/tmp/$BACKUP_BASE_NAME.sql"
docker exec -it karbonowy mysqldump prestashop > "$BACKUP_SQL_PATH"
7z a "$HOME/backup/$BACKUP_BASE_NAME.7z" "$BACKUP_SQL_PATH"
