# User Documentation

This guide explains how an end user or administrator can interact with the Inception infrastructure.

## Services Provided by the Stack
[cite_start]This infrastructure provides a fully containerized, secure WordPress environment[cite: 237]:
- [cite_start]**NGINX:** Acts as the sole entrypoint to the infrastructure, serving traffic exclusively over HTTPS (TLSv1.2/1.3) on port 443[cite: 93, 128].
- [cite_start]**WordPress:** The core CMS platform, running on PHP-FPM, handling dynamic content generation[cite: 94].
- [cite_start]**MariaDB:** The relational database storing all site data, users, and configurations, completely isolated from external network access[cite: 95].

## Start and Stop the Project
[cite_start]The entire lifecycle of the project is managed via the `Makefile` located at the root of the repository[cite: 29].

- [cite_start]**To start the project:** Run `make` or `make all`[cite: 30, 238].
- [cite_start]**To stop the project:** Run `make down` (stops and removes containers) or `make stop` (pauses containers)[cite: 238].
- **To reset the project:** Run `make fclean` to wipe all containers, images, and volumes, followed by `make re` to rebuild from scratch.

## Accessing the Website and Administration Panel
- [cite_start]**Public Website:** `https://rbarkhud.42.fr` [cite: 120, 239]
- [cite_start]**Administration Panel:** `https://rbarkhud.42.fr/wp-admin` [cite: 239]
*(Note: Because the project uses a self-signed certificate, your browser will display a security warning. You must explicitly accept the risk to proceed.)*

## Locate and Manage Credentials
[cite_start]For security reasons, no passwords are hardcoded in the repository[cite: 123, 201]. [cite_start]Credentials must be managed manually via Docker Secrets[cite: 240].

1. [cite_start]Create a `secrets/` directory next to the `srcs/` folder[cite: 157].
2. Create the following text files and insert your desired passwords:
   - `secrets/db_password.txt`
   - `secrets/db_root_password.txt`
   - `secrets/wordpress_root_password.txt`
   - `secrets/wordpress_user_password.txt`

## Check that Services are Running Correctly
[cite_start]You can verify the health and status of the stack using Docker CLI commands[cite: 241]:
- `docker compose -f ./srcs/docker-compose.yml ps`: Lists the status of the webserver, database, and wordpress containers.
- `docker logs webserver`: View incoming web traffic and Nginx errors.
- `docker logs wordpress`: View PHP-FPM processes and WordPress initialization output.
- `docker logs database`: View MariaDB runtime logs.