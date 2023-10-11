#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <database_name>"
  exit 1
fi

DB_NAME="$1"

tables=$(mysql $DB_NAME -e "SHOW TABLES" | tail -n +2)

for table in $tables; do
  mysql $DB_NAME -e "ALTER TABLE $table ENGINE=InnoDB"
  mysql $DB_NAME -e "ALTER TABLE $table ENCRYPTION='Y'"
done

echo "Storage engine and encryption enabled successfully for all tables in database: $DB_NAME"


### Change default storage engine
#[mysqld]
#default-storage-engine = innodb
