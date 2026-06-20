# Developer Documentation

[cite_start]This document describes the technical implementation and management of the Inception stack for developers[cite: 243, 244].

## Set Up the Environment from Scratch
1. [cite_start]**Prerequisites:** You must have Docker, Docker Compose (V2), and Make installed on your host machine[cite: 83]. [cite_start]You must also map your local IP to `rbarkhud.42.fr` in your `/etc/hosts` file[cite: 119, 120, 245].
2. [cite_start]**Configuration Files:** Environment variables defining domain names and database users are located in `srcs/.env`[cite: 125, 245].
3. [cite_start]**Secrets:** As defined in the User Doc, create the `secrets/` directory and populate the four required `.txt` password files before building the project[cite: 201, 245].

## Build and Launch the Project
[cite_start]The `Makefile` serves as the primary build automation tool[cite: 29].

1. `make create_dirs`: Automatically creates the required `/home/rbarkhud/data/` directories if they do not exist.
2. [cite_start]`make up`: Executes `docker compose -f ./srcs/docker-compose.yml up -d --build`[cite: 30]. [cite_start]This reads the Compose file, builds the individual `debian:bookworm-slim` images using the Dockerfiles in `srcs/requirements/`, provisions the internal `inception` network, and launches the containers in detached mode[cite: 86, 246].

## Use Relevant Commands to Manage Containers and Volumes
- **Execute Commands Inside Containers:** `docker exec -it <container_name> /bin/bash`
- **Verify WP-CLI:** `docker exec -it wordpress wp --version --allow-root`
- [cite_start]**Test Database Connectivity:** `docker exec -it database mysql -u root -p` (enter the root password defined in your secrets file)[cite: 247].
- [cite_start]**Prune System:** `docker system prune -af` (Used in `make fclean` to wipe the Docker cache and unused networks)[cite: 247].

## Data Persistence Strategy
[cite_start]The project ensures no data is lost during container crashes or rebuilds by utilizing named Docker volumes bound to specific host directories[cite: 98, 101, 248].

- **Database Storage:** The `db_data` volume is mapped to `/home/rbarkhud/data/mariadb`. It mounts to `/var/lib/mysql/` inside the database container[cite: 96, 99].
- **Web Storage:** The `wordpress_data` volume is mapped to `/home/rbarkhud/data/wordpress`. [cite_start]It mounts to `/var/www/` across both the Nginx and WordPress containers, allowing Nginx to serve static files directly and pass PHP processing to the WordPress container[cite: 97, 99].