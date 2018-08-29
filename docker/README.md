# Docker Usage

## Production

1. Setup docker-compose
* Copy file `docker/envs/prod.env.example` to `docker/envs/prod.env` and adjust MYSQL_DATABASE variable.

2. Start services
```bash
docker-compose -f docker-compose.yml -f docker/docker-compose.prod.yml up -d
```

3. Setup LORIS

* Get credentials to do the first access using the command:
```bash
docker-compose logs webapp
```

* Access the system and do your adjustments.