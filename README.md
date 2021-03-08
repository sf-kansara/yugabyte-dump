## Create DB sql file dumps for yugabyte db

## Export
### DB sql
`public` schema for user, customer & sales DBs
```bash
./db_sql_export.sh -h localhost -p 5432 -U postgres --db-names users-db,customers-db,sales-db --schema public
```

## Import
### DB sql
`public` schema for user, customer & sales DBs
```bash
./db_sql_import.sh -h localhost -p 5432 -U postgres --dump-folder db-sql-dump-20210303-17:59:33
```
