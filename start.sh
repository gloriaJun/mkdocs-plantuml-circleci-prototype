#!/bin/sh

command=$1

docker compose -f docker-compose.yml up -d plantuml-server

if [ "${command}" == serve ]; then
  mkdocs serve
else
  mkdocs build
fi

# run
#COMMAND=${command} docker compose -f docker-compose.yml run --rm=true mkdocs-builder

docker compose stop plantuml-server

# clean images
docker rmi `docker images --filter dangling=true -q` 2> /dev/null
