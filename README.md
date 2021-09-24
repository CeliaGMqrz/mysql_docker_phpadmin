# Contenedores de Bases de datos

## Objetivo

Inicializacion, carga, backup, recovery, replicación y monitorización de contenedores de bases de datos. 

En este caso vamos a usar MySQL.

## Requisitos 

* [Instalar Docker y Docker-compose](https://www.celiagm.es/posts/sistemas/docker/)
* [Instalar Git](https://www.atlassian.com/es/git/tutorials/install-git)


## Cargar variables de entorno y crear directorio de trabajo

```shell
PROJECTS_DIR=$HOME/Projects
PROJECT_DIR=$PROJECTS_DIR/mysql_docker_phpadmin
mkdir -p $PROJECTS_DIR
PROJECT_NAME=mysql_docker_phpadmin
PROJECT_DIR=$PROJECTS_DIR/$PROJECT_NAME

```

Cargar también las variables de entorno necesarias del fichero [.env](https://github.com/CeliaGMqrz/mysql_docker_phpadmin/blob/main/.env)

## Clonar el respositorio del proyecto

```shell 
git clone https://github.com/CeliaGMqrz/mysql_docker_phpadmin.git $PROJECT_DIR
```

## Instalar y cargar baids 

Los baids son alias que llaman a funciones predefinidas para el proyecto.
Para descargar baids acceder [aquí](https://github.com/rcmorano/baids#installation)

```shell 
curl -sSL https://raw.githubusercontent.com/rcmorano/baids/master/baids | bash -s install
ln -fs $PROJECT_DIR/baids $HOME/.baids/functions.d/$PROJECT_NAME
baids-reload
```


## Desplegar el entorno

```shell 
cd $PROJECT_DIR
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

