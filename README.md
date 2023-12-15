# mkdocks build prototype

- plantuml
- mermaid

## Requirements

- Python v3.10 
- pip 23.3.1

## Run or Build

```bash
sh ./start.sh <serve | build>
```

## Docker Tips

- build and run

```bash
cd <project_root_dir>

# to rebuild

docker compose -f docker-compose.yml create
docker compose -f docker-compose.yml run --rm mkdocs-builder
```

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
