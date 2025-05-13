#!/bin/bash

########################################
# Default configuration values
########################################
DOCKER_DIR="/custom/scripts/homelab-docker/docker_app_host"
ENV_FILE="/custom/files/internal_domain_name.env"

########################################
# Functions
########################################

# Usage
usage() {
  printf "
  Usage: $0 [start|stop|restart|status]

  Options:
    start    - Start all Docker containers
    stop     - Stop all Docker containers
    restart  - Restart all Docker containers
    status   - Show status of all Docker containers

  Example: ./control.sh stop

"

  exit 1
}

# Start containers
start_containers() {
  find "$DOCKER_DIR" -maxdepth 1 -mindepth 1 -type d | sort | while IFS= read -r D; do
    docker compose --env-file "$ENV_FILE" -f "$D"/docker-compose.yml up -d
  done
}

# Stop containers
stop_containers() {
  find "$DOCKER_DIR" -maxdepth 1 -mindepth 1 -type d | sort | while IFS= read -r D; do
    docker compose --env-file "$ENV_FILE" -f "$D"/docker-compose.yml down
  done
}

# Show container status
show_status() {
  # https://docs.docker.com/reference/cli/docker/container/ls/#format
  docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.RunningFor}}\t{{.Status}}\t{{.Ports}}"
}

########################################
# Options
########################################

if [ $# -eq 0 ]; then
  usage
fi

case "$1" in
  start)
    start_containers
    ;;
  stop)
    stop_containers
    ;;
  restart)
    stop_containers
    sleep 5
    start_containers
    ;;
  status)
    show_status
    ;;
  *)
    usage
    ;;
esac

exit 0
