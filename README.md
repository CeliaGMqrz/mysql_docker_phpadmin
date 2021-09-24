# Contenedores de Bases de datos

## Objetivo

Inicializacion, carga, backup, recovery, replicación y monitorización de contenedores de bases de datos. 

En este caso vamos a usar MySQL.

## Requisitos 

* [Instalar Docker y Docker-compose](https://www.celiagm.es/posts/sistemas/docker/)
* [Instalar Git](https://www.atlassian.com/es/git/tutorials/install-git)


## Cargar variables de entorno y crear directorio de trabajo

```shell
PROJECTS_DIR=$HOME/Projects/test
PROJECT_DIR=$PROJECTS_DIR/mysql_docker_phpadmin
mkdir -p $PROJECTS_DIR
PROJECT_NAME=mysql_docker_phpadmin
PROJECT_DIR=$PROJECTS_DIR/$PROJECT_NAME
```

Cargar también las variables de entorno necesarias del fichero .env

## Clonar el respositorio del proyecto

```shell 
git clone https://github.com/CeliaGMqrz/mysql_docker_phpadmin.git $PROJECT_DIR
```

## Instalar y cargar baids 

Los baids son alias que llaman a funciones predefinidas para el proyecto.
Para descargar baids acceder [aquí](https://github.com/rcmorano/baids#installation)

```shell 
ln -fs $PROJECT_DIR/baids $HOME/.baids/functions.d/$PROJECT_NAME
baids-reload
```


## Desplegar el entorno

```shell 
dev-mysql_docker_phpadmin.test-deploy
```

Comprobamos que está funcionando

```shell 
docker ps
```

![]()

## Cargar la base de datos 

Indicar la ruta del fichero sql

```shell 
dev-mysql_docker_phpadmin.test-mysql-import-db /path/to/dump.sql
```

## Exportar la base de datos 

Este backup se guarda en el directorio data del proyecto.

```shell 
dev-mysql_docker_phpadmin.test-mysql-dump-db 
```


Opción 1

`mysql-docker.sh`
```shell
# Backup
docker exec CONTAINER /usr/bin/mysqldump -u root --password=root DATABASE > backup.sql

# Restore
cat backup.sql | docker exec -i CONTAINER /usr/bin/mysql -u root --password=root DATABASE
```

Opción 2

```shell
# Backup
docker exec some-mysql sh -c 'exec mysqldump --all-databases -u<user> -p<password> <database>' > /some/path/on/your/host/all-databases.sql


# Restore
docker exec -i some-mysql sh -c 'exec mysql -u<user> -p<password> <database>' < /some/path/on/your/host/all-databases.sql

```

docker exec some-mysql sh -c 'exec mysqldump --all-databases -u root -p root escuela' > /home/cgarcia/dockerCompose/mysql