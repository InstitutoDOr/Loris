# Docker Usage

## Production

1. Setup docker-compose
* Copy file `docker/envs/prod.env.example` to `docker/envs/prod.env` and adjust MYSQL_DATABASE variable.

2. Setup MySQL
```bash
docker-compose -f docker-compose.yml -f docker/docker-compose.prod.yml up -d db
docker logs loris_db_1 2>&1 | grep PASSWORD
```

3. Setup LORIS
* Setup database credentials in "docker/envs/prod.env"
* Start services 
```bash
docker-compose -f docker-compose.yml -f docker/docker-compose.prod.yml up -d db
```
