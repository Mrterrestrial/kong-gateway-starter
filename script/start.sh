#!/usr/bin/env bash
set -e

# 1. Load environment
source ../.env

# 2. Start Docker services
echo "=== Starting Docker Compose ==="
docker-compose up -d

# (Optional) If you don't rely on 'docker-start' for migrations, you can do:
# echo "=== Running Kong migrations ==="
# docker-compose run --rm kong kong migrations bootstrap

echo "=== Waiting for Kong to initialize ==="
sleep 10  # Adjust as needed

# 3. Read services.conf and register each service in Kong
while read -r line
do
  # Skip empty lines and comments
  if [[ -z "$line" || "$line" == \#* ]]; then
    continue
  fi

  SERVICE_NAME="$(echo $line | cut -d'=' -f1)"
  SERVICE_URL="$(echo $line | cut -d'=' -f2)"

  echo "Registering service: $SERVICE_NAME -> $SERVICE_URL"
  curl -s -X POST http://localhost:${KONG_ADMIN_PORT}/services \
    --data "name=$SERVICE_NAME" \
    --data "url=$SERVICE_URL" \
    || echo "Failed to create service $SERVICE_NAME"

  # Create a route (example prefix: /api/v1/<service_name>)
  echo "Creating route for: $SERVICE_NAME"
  curl -s -X POST http://localhost:${KONG_ADMIN_PORT}/services/$SERVICE_NAME/routes \
    --data "paths[]=/api/v1/${SERVICE_NAME}" \
    --data "strip_path=true" \
    --data "name=${SERVICE_NAME}-route" \
    || echo "Failed to create route for $SERVICE_NAME"
done < ../services.conf

echo "=== Setup Complete! ==="
echo "Kong Admin API:  http://localhost:${KONG_ADMIN_PORT}"
echo "Kong Proxy:      http://localhost:${KONG_PROXY_HTTP}"
echo "Konga (UI):      http://localhost:${KONGA_HOST_PORT}"
