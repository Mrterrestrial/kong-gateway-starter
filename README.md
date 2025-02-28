# Kong Starter

This repository offers a ready-to-use Docker Compose setup for deploying Kong Gateway with PostgreSQL and Konga UI.

## Project Structure

- **docker-compose.yml**: Defines the Docker services for PostgreSQL, Kong Gateway, and Konga UI.
- **.env**: Environment variables for configuring the services.
- **services.conf**: Configuration file listing services to be registered with Kong.
- **script/start.sh**: Bash script to start the Docker services and register services with Kong.
- **script/stop.sh**: Bash script to stop and remove the Docker services.

## Usage

1. **Start Services**: Run start.sh to start the Docker services and register the services defined in services.conf.
2. **Stop Services**: Run stop.sh to stop and remove the Docker services.

## Configuration

- **PostgreSQL**: Configured via environment variables in .env.
- **Kong Gateway**: Configured via environment variables in .env and docker-compose.yml.
- **Konga UI**: Configured via environment variables in .env.

