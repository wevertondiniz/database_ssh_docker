#!/bin/bash
#Criado por Charles Sampaio
#Execução de banco de dados em docker de forma simples. 

DOCKER_VOLUME_DIR=$HOME/development
CONTAINER_NAME="mongo"
VOLUME_DIR=$DOCKER_VOLUME_DIR/$CONTAINER_NAME
IMAGE_NAME=$CONTAINER_NAME


create(){
id=$(docker images $CONTAINER_NAME --format "{{.ID}}")
if [ -z $id ]; then
    docker pull mongo
else
    echo $CONTAINER_NAME:$id
fi

}

execute () {
  docker run  --name $CONTAINER_NAME \
              -p 27017:27017 \
              -m "512m" \
              -d \
              $IMAGE_NAME            
}

#Cria diretorio
verifydir(){
    if [ -e $VOLUME_DIR ]; then 
       echo "Database" $VOLUME_DIR
    else 
        echo "Create database path..."
        mkdir $VOLUME_DIR
        echo "Database" $VOLUME_DIR
    fi    
}

#Executa o container
id=$(docker ps -a --filter "name=$CONTAINER_NAME" --format "{{.ID}}")
if [ -z "$id" ]; then
    create
    execute
    exit 0
else
    
    docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'
    verifydir
fi


