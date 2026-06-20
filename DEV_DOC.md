# Developer Documentation

This document describes the technical implementation and management of the Inception stack for developers.

## Set Up the Environment from Scratch
1. **Prerequisites:** You must have Docker, Docker Compose (V2), and Make installed on your host machine. You must also map your local IP to `rbarkhud.42.fr` in your `/etc/hosts` file.
2. **Configuration Files:** Environment variables defining domain names and database users are located in `srcs/.env`.
3. **Secrets:** As defined in the User Doc, create the `secrets/` directory and populate the four required `.txt` password files before building the project.

## Build and Launch the Project
The `Makefile` serves as the primary build automation tool.

1. `make create_dirs`: Automatically creates the required `/home/rbarkhud/data/` directories if they do not exist.
2. `make up`: Executes `docker compose -f ./srcs/docker-compose.yml up -d --build`. This reads the Compose file, builds the individual `debian:bookworm-slim` images using the Dockerfiles in `srcs/requirements/`, provisions the internal `inception` network, and launches the containers in detached mode.

## Use Relevant Commands to Manage Containers and Volumes
- **Execute Commands Inside Containers:** `docker exec -it <container_name> /bin/bash`
- **Verify WP-CLI:** `docker exec -it wordpress wp --version --allow-root`
- **Test Database Connectivity:** `docker exec -it database mysql -u root -p` (enter the root password defined in your secrets file).
- **Prune System:** `docker system prune -af` (Used in `make fclean` to wipe the Docker cache and unused networks).

## Data Persistence Strategy
The project ensures no data is lost during container crashes or rebuilds by utilizing named Docker volumes bound to specific host directories.

- **Database Storage:** The `db_data` volume is mapped to `/home/rbarkhud/data/mariadb`. It mounts to `/var/lib/mysql/` inside the database container.
- **Web Storage:** The `wordpress_data` volume is mapped to `/home/rbarkhud/data/wordpress`. It mounts to `/var/www/` across both the Nginx and WordPress containers, allowing Nginx to serve static files directly and pass PHP processing to the WordPress container.