#!/usr/bin/env bash
set -e

echo "=== Stopping & removing Docker Compose services ==="
docker-compose down

echo "=== Done! ==="
