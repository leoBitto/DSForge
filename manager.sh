#!/bin/bash

# Percorso del file docker-compose
COMPOSE_FILE=./docker/docker-compose.yml

# Creare la cartella logs se non esiste
LOG_DIR=./logs
mkdir -p $LOG_DIR

# Percorso della directory del progetto
PROJECT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

# Funzione per generare un nome file di log con timestamp
generate_log_filename() {
    echo $LOG_DIR/docker_compose_$(date '+%Y%m%d_%H%M%S').log
}

# Funzione per mostrare l'uso dello script
usage() {
    echo "Uso: $0 {build|start|stop|restart|logs|clean}"
    echo "Comandi:"
    echo "  build    - Costruisce l'immagine Docker"
    echo "  start    - Avvia il servizio"
    echo "  stop     - Ferma il servizio"
    echo "  restart  - Riavvia il servizio"
    echo "  logs     - Mostra i log in tempo reale"
    echo "  clean    - Rimuove container del progetto corrente"
    exit 1
}

# Verifica che Docker sia installato
check_docker() {
    if ! command -v docker &> /dev/null; then
        echo "Errore: Docker non è installato"
        exit 1
    fi
}

# Gestisce i comandi
case "$1" in
    build)
        check_docker
        LOG_FILE=$(generate_log_filename)
        echo "Costruzione dell'immagine Docker... (log in $LOG_FILE)"
        docker compose -f $COMPOSE_FILE build 2>&1 | tee $LOG_FILE
        ;;
    start)
        check_docker
        LOG_FILE=$(generate_log_filename)
        echo "Avvio del servizio Streamlit... (log in $LOG_FILE)"
        docker compose -f $COMPOSE_FILE up -d 2>&1 | tee $LOG_FILE
        ;;
    stop)
        check_docker
        LOG_FILE=$(generate_log_filename)
        echo "Arresto del servizio Streamlit... (log in $LOG_FILE)"
        docker compose -f $COMPOSE_FILE down 2>&1 | tee $LOG_FILE
        ;;
    logs)
        check_docker
        echo "Visualizzazione dei log del servizio Streamlit..."
        docker compose -f $COMPOSE_FILE logs -f
        ;;
    restart)
        check_docker
        LOG_FILE=$(generate_log_filename)
        echo "Riavvio del servizio Streamlit... (log in $LOG_FILE)"
        docker compose -f $COMPOSE_FILE down
        docker compose -f $COMPOSE_FILE up -d 2>&1 | tee $LOG_FILE
        ;;
    clean)
        check_docker
        LOG_FILE=$(generate_log_filename)
        echo "Pulizia selettiva... (log in $LOG_FILE)"
        docker compose -f $COMPOSE_FILE down --rmi local --volumes 2>&1 | tee $LOG_FILE
        echo "Per una pulizia più profonda, usa comandi Docker specifici manualmente"
        ;;
    *)
        usage
        ;;
esac

exit 0