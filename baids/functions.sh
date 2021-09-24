#!/bin/bash


# Shell para entrar en phpadmin
function dev-mysql_docker_phpadmin.test-phpadmin-shell() {

  docker exec -ti phpadmin /bin/bash
}

# Shell para entrar en mysql_server
function dev-mysql_docker_phpadmin.test-mysql-shell() {

  docker exec -ti mysql_server /bin/bash

}

# Desplegar el entorno
function dev-mysql_docker_phpadmin.test-deploy() {
  

  docker-compose --file ${PROJECT_DIR}/docker-compose.yaml up -d

}

# Eliminar el entorno
function dev-mysql_docker_phpadmin.test-down() {

  docker-compose --file ${PROJECT_DIR}/docker-compose.yaml down

}

# Obtener la ip de mysql_server
function dev-mysql_docker_phpadmin.test-get-mysql-ip() {


  IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' mysql_server)

  echo $IP
}

# Obtener la ip de phpadmin
function dev-mysql_docker_phpadmin.test-get-mysql-ip() {


  IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' mysql_server)

  echo $IP
}

# Backup
function dev-mysql_docker_phpadmin.test-mysql-dump-db() {

  # Exportamos la fecha de hoy
  TIMESTAMP=$(date +'%Y%m%d%H%M')
  # Ejecutamos desde fuera un volcado de la base de datos al directorio data de nuestro proyecto
  docker exec mysql_server \
  bash -c 'exec mysqldump --all-databases -u root -p "$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' > $PROJECT_DIR/data/${PROJECT_NAME}-dump-${TIMESTAMP}.sql
  echo "[!] Backup respaldado en $PROJECT_DIR/data/${PROJECT_NAME}-dump-${TIMESTAMP}.sql"

}

# Importación de db
function dev-mysql_docker_phpadmin.test-mysql-import-db() {


  [ ! -n "$1" ] && echo -e "[!] sql dump not found \n
Usage: dev-mysql_docker_phpadmin.test-mysql-import-db /path/to/dump.sql" && return
  
  SQL_DUMP=$1

  docker exec -i mysql_server \
  bash -c 'exec mysql -u root -p "$MYSQL_ROOT_PASSWORD"' < $SQL_DUMP

  echo "[!] Database restored from $SQL_DUMP"

}



