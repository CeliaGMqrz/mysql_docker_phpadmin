#!/bin/bash

# Entorno Dev
function dev-mysql_docker_phpadmin.test-init() {

  export ENVIRONMENT="dev"
  mysql_docker_phpadmin.test-init ${ENVIRONMENT}

}

# Shell para entrar en phpadmin
function dev-mysql_docker_phpadmin.test-phpadmin-shell() {

  dev-mysql_docker_phpadmin.test-init
  docker exec -ti phpadmin /bin/bash
}

# Shell para entrar en mysql_server
function dev-mysql_docker_phpadmin.test-mysql-shell() {

  dev-mysql_docker_phpadmin.test-init
  docker exec -ti mysql_server /bin/bash

}

# Desplegar el entorno
function dev-mysql_docker_phpadmin.test-deploy() {

  dev-mysql_docker_phpadmin.test-init
  docker-compose --file ${PROJECT_DIR}/docker-compose.yaml up -d

}

# Eliminar el entorno
function dev-mysql_docker_phpadmin.test-down() {

  dev-mysql_docker_phpadmin.test-init
  docker-compose --file ${PROJECT_DIR}/docker-compose.yaml down

}

# Obtener la ip de mysql_server
function dev-mysql_docker_phpadmin.test-get-mysql-ip() {

  dev-mysql_docker_phpadmin.test-init

  IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' mysql_server)

  echo $IP
}

# Obtener la ip de phpadmin
function dev-mysql_docker_phpadmin.test-get-mysql-ip() {

  dev-mysql_docker_phpadmin.test-init

  IP=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' mysql_server)

  echo $IP
}

# Backup
function dev-mysql_docker_phpadmin.test-mysql-dump-db() {

  dev-mysql_docker_phpadmin.test-init
  # Exportamos la fecha de hoy
  TIMESTAMP=$(date +'%Y%m%d%H%M')
  # Ejecutamos desde fuera un volcado de la base de datos al directorio data de nuestro proyecto
  docker exec mysql_server \
  bash -c 'exec mysqldump --all-databases -u root -p "$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE"' > $PROJECT_DIR/data/${PROJECT_NAME}-dump-${TIMESTAMP}.sql
  echo "[!] Backup respaldado en $PROJECT_DIR/data/${PROJECT_NAME}-dump-${TIMESTAMP}.sql"

}

# Importación de db
function dev-mysql_docker_phpadmin.test-mysql-import-db() {

  dev-mysql_docker_phpadmin.test-init

  [ ! -n "$1" ] && echo -e "[!] sql dump not found \n
Usage: dev-mysql_docker_phpadmin.test-mysql-import-db /path/to/dump.sql" && return
  
  SQL_DUMP=$1

  docker exec -i mysql_server \
  bash -c 'exec mysql -u root -p "$MYSQL_ROOT_PASSWORD"' < $SQL_DUMP

  echo "[!] Database restored from $SQL_DUMP"

}



