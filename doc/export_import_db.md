
## Backup and Restore

Si queremos exportar o importar una base de datos de forma manual te pueden ayudar estas opciones:


### Opción 1

```shell
# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE
```

### Opción 2

```shell
# Backup
docker exec some-mysql sh -c 'exec mysqldump --all-databases -u<user> -p<password> <database>' > /some/path/on/your/host/all-databases.sql


# Restore
docker exec -i some-mysql sh -c 'exec mysql -u<user> -p<password> <database>' < /some/path/on/your/host/all-databases.sql

```
### Ejemplo de Backup o exportación manual

```shell
cgarcia@ws-cgarcia:~/dockerCompose/mysql$ docker exec mysql_server sh -c 'exec mysqldump --all-databases -u root -p securepass escuela' > /home/cgarcia/dockerCompose/mysql/backup.sql


cgarcia@ws-cgarcia:~/dockerCompose/mysql$ ls -l
total 64
-rw-rw-r-- 1 cgarcia          cgarcia            203 sep 24 12:15 backup.sql
-rw-rw-r-- 1 cgarcia          cgarcia           6089 sep 24 11:50 baids.sh
drwxrwxrwt 6 systemd-coredump systemd-coredump  4096 sep 23 17:47 data
-rw-rw-r-- 1 cgarcia          cgarcia           1164 sep 23 14:16 docker-compose.yaml
-rw-rw-r-- 1 cgarcia          cgarcia          39052 sep 23 14:41 fase2_mysql.sql
-rw-rw-r-- 1 cgarcia          cgarcia           1357 sep 24 12:14 README.md
```