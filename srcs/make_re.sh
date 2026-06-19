#!/bin/bash

docker compose down -v
docker rmi $(docker images -qa)
docker builder prune -f
# docker compose up -d
