# docker_app_host

## Explanation

Directory containing Docker Compose files that are currently being used, aka "production".

## Requirements

This repo assumes a very specific setup:

* DNS is setup correctly
* Traefik config in the correct place in the Traefik volume (this also includes the correct [Certificate Resolver](https://doc.traefik.io/traefik/https/acme/#certificate-resolvers) setup)
* Environment variables in the correct directory
* All `docker compose...` commands also have an env var file passed to them to allow parsing the `SECRET_INTERNAL_DOMAIN_NAME` littered throughout all these files
* All "stacks" are controlled via the [`control.sh`](https://github.com/loganmarchione/homelab-docker/blob/master/control.sh) script
