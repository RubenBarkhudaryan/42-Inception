# User Documentation

This guide explains how an end user or administrator can interact with the Inception infrastructure.

## Services Provided by the Stack
This infrastructure provides a fully containerized, secure WordPress environment:
- **NGINX:** Acts as the sole entrypoint to the infrastructure, serving traffic exclusively over HTTPS (TLSv1.2/1.3) on port 443.
- **WordPress:** The core CMS platform, running on PHP-FPM, handling dynamic content generation.
- **MariaDB:** The relational database storing all site data, users, and configurations, completely isolated from external network access.

## Start and Stop the Project
The entire lifecycle of the project is managed via the `Makefile` located at the root of the repository.

- **To start the project:** Run `make` or `make all`.
- **To stop the project:** Run `make down` (stops and removes containers) or `make stop` (pauses containers).
- **To reset the project:** Run `make fclean` to wipe all containers, images, and volumes, followed by `make re` to rebuild from scratch.

## Accessing the Website and Administration Panel
- **Public Website:** `https://rbarkhud.42.fr`
- **Administration Panel:** `https://rbarkhud.42.fr/wp-admin`
*(Note: Because the project uses a self-signed certificate, your browser will display a security warning. You must explicitly accept the risk to proceed.)*

## Locate and Manage Credentials
For security reasons, no passwords are hardcoded in the repository.Credentials must be managed manually via Docker Secrets.

1. Create a `secrets/` directory next to the `srcs/` folder.
2. Create the following text files and insert your desired passwords:
   - `secrets/db_password.txt`
   - `secrets/db_root_password.txt`
   - `secrets/wordpress_root_password.txt`
   - `secrets/wordpress_user_password.txt`

## Check that Services are Running Correctly
You can verify the health and status of the stack using Docker CLI commands:
- `docker compose -f ./srcs/docker-compose.yml ps`: Lists the status of the webserver, database, and wordpress containers.
- `docker logs webserver`: View incoming web traffic and Nginx errors.
- `docker logs wordpress`: View PHP-FPM processes and WordPress initialization output.
- `docker logs database`: View MariaDB runtime logs.