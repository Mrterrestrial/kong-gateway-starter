#!/usr/bin/env bash
set -e

# 1. Load environment
source ../.env

#Export environment variables
export POSTGRES_USER
export POSTGRES_DB
export POSTGRES_PASSWORD
export POSTGRES_HOST_PORT
export KONG_ADMIN_PORT
export KONG_PROXY_HTTP
export KONG_PROXY_HTTPS
export KONG_ADMIN_HTTPS
export KONGA_HOST_PORT

echo "=== Stopping & removing Docker Compose services ==="
docker-compose down

echo "=== Done! ==="
