#!/bin/sh

build_option=$1

function _exec() {
  command=$1
  message=$2

  echo ""
  echo "o ${message}..."
  echo " - command: ${command}"
  eval ${command}
}

## run plantuml server
_exec "docker compose -f docker-compose.yml up -d plantuml-server" "Run plantuml Server on Docker Container"

if [ "${build_option}" == "build" ]; then
  echo "hi"
fi

_exec "mkdocs ${build_option}" "Run mkdocs"

# run
#COMMAND=${command} docker compose -f docker-compose.yml run --rm=true mkdocs-builder

_exec "docker compose stop plantuml-server" "Stop Docker Container"

# clean images
_exec "docker rmi `docker images --filter dangling=true -q` 2> /dev/null" "Clean dangling docker images"
