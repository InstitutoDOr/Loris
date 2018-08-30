# Docker Usage

## Environments
* [Production](#production)
* [Development](#development)

### Production

> _Note_: Be careful when using Docker in production environments (
    [Link 1](https://ghost.kontena.io/docker-in-production-good-bad-ugly/), 
    [Link 2](https://blog.cloud66.com/9-crtitical-decisions-needed-to-run-docker-in-production/), 
    [Link 3](https://www.quora.com/Is-Docker-ready-for-production)
).

1. Setup docker-compose

    * Copy file `docker/envs/prod.env.example` to `docker/envs/prod.env`.
    * Configure `docker/envs/prod.env`

2. Start services

    ```bash
    docker-compose -f docker-compose.yml -f docker/docker-compose.prod.yml up -d
    ```

    _Note_: If you want change LORIS_VERSION and/or LORIS_PORT, you can configure it in `docker-compose.yml` file or prepend these environment variables to the command above:

    ```bash
    LORIS_VERSION=v20.0.1 \
    LORIS_PORT=80 \
    docker-compose -f docker-compose.yml -f docker/docker-compose.prod.yml up -d
    ```

3. Setup LORIS

    * Get credentials to do the first access using the command:

        _Note_: services need some time to be ready. If credentials are not yet available, run this command again after some seconds.

        ```bash
        docker-compose logs webapp
        ```

    * Access the system, change `admin` password and start to use LORIS.


> _OBS._: Don't forget to set up backup routines.


___
### Development

1. Start services

    ```bash
    docker-compose -f docker-compose.yml -f docker/docker-compose.dev.yml up -d
    ```

2. Prepare your environment

    * Command below will download dependencies and create some files ad folders:

        ```bash
        docker-compose exec webapp /bin/bash docker/scripts/init-dev.sh
        ```

3. Setup LORIS

    * Get credentials to do the first access using the command:

        _Note_: services need some time to be ready. If credentials are not yet available, run this command again after some seconds.

        ```bash
        docker-compose logs webapp
        ```

    * Access the system, change `admin` password and start to test LORIS.