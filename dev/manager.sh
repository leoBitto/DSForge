#!/bin/bash

# Nome del container e immagine
CONTAINER_NAME="dsforge_dev"
IMAGE_NAME="dsforge_dev_image"

# Funzione per mostrare l'uso dello script
usage() {
    echo "Uso: ./manager.sh {start|stop|restart|status|logs|build}"
    exit 1
}

# Avvia il container
start() {
    echo "Avvio del container $CONTAINER_NAME..."
    docker run -d --name $CONTAINER_NAME \
        -p 8888:8888 \
        -v $(pwd)/notebooks:/home/jovyan/work \
        -v $(pwd)/../shared/data:/data \
        $IMAGE_NAME
    echo "server ready at http://localhost:8888"
}

# Ferma il container
stop() {
    echo "Arresto del container $CONTAINER_NAME..."
    docker stop $CONTAINER_NAME
    docker rm $CONTAINER_NAME
}

# Riavvia il container
restart() {
    echo "Riavvio del container $CONTAINER_NAME..."
    stop
    start
}

# Controlla lo stato del container
status() {
    echo "Stato del container $CONTAINER_NAME:"
    docker ps -a | grep $CONTAINER_NAME
}

# Mostra i log del container
logs() {
    echo "Log del container $CONTAINER_NAME:"
    docker logs $CONTAINER_NAME
}

# Costruisce l'immagine Docker
build_image() {
    echo "Costruzione dell'immagine $IMAGE_NAME..."
    docker build -t $IMAGE_NAME -f Dockerfile .
}

# Controllo dei parametri passati allo script
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    restart)
        restart
        ;;
    status)
        status
        ;;
    logs)
        logs
        ;;
    build)
        build_image
        ;;
    *)
        usage
        ;;
esac
