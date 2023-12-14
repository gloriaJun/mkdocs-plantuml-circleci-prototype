# mkdocks build prototype

- plantuml
- mermaid

## Requirements

- Python v3.10 
- pip 23.3.1

## Install

```bash
pip install -r requirements.txt
```

## run

```bash
mkdocks server
```

## build

```bash
mkdocs build
```

## Run with docker-compose
```bash
cd <project_root_dir>

# to rebuild
docker compose -f docker-compose.yml create --build

docker compose -f docker-compose.yml create
docker compose -f docker-compose.yml run mkdocs-builder
```

If  you want to build again
```bash
docker compose -f docker-compose.yml create --build
```

## Tips

- remove all images, container, volumes

```bash
docker system prune
# including stopped, unused images
docker system prune -a
```

- remove dangling images

```bash
docker images -f dangling=true
docker image prune
```

- remove all images

```bash
docker rmi $ (docker images -a -q)
```
