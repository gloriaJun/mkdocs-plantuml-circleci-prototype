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

if [ "${CI}" != true ]; then
  ## run plantuml server
  _exec "docker compose -f docker-compose.yml up -d plantuml-server" "Run plantuml Server on Docker Container"
  nc -z localhost 8090
  if [ $? != 0 ]; then
    echo ""
    echo "[Error] Plantuml Server is not running..."
    exit 1
  fi
fi

_exec "mkdocs ${build_option}" "Run mkdocs"

if [ "${build_option}" == "build" ]; then
  # remove exclude dir
  _exec "rm -rf site/uml" "Remove exclude directory for deploying"

  # find the imported uml image files
  find site -type f -name '*.html' -print | xargs awk '/\/diagrams\//'
fi

# run
#COMMAND=${command} docker compose -f docker-compose.yml run --rm=true mkdocs-builder

_exec "docker compose stop plantuml-server" "Stop Docker Container"

# clean images
_exec "docker rmi `docker images --filter dangling=true -q` 2> /dev/null" "Clean dangling docker images"
