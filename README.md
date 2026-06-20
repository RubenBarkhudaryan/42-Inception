*This project has been created as part of the 42 curriculum by rbarkhud.*

## Description
This project aims to broaden your knowledge of system administration by using Docker. The goal is to set up a small infrastructure composed of different services under specific rules. It implements a LEMP-like stack (Linux, Nginx, MariaDB, PHP) entirely within Docker containers. Every service runs in its own dedicated container, built from scratch using `debian:bookworm-slim`, linked via a custom Docker network, and secured using Docker Secrets.

## Instructions
1. Clone the repository.
2. Create a `secrets/` directory containing your password `.txt` files (see USER_DOC.md for details).
3. Ensure your `srcs/.env` file is populated with your domain and database names.
4. Run `make all` from the root directory to build and launch the infrastructure.
5. Open `https://rbarkhud.42.fr` in your browser.

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress Documentation](https://wordpress.org/support/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- **AI Usage:** AI was used to assist in debugging container entrypoint scripts (ensuring idempotency), validating Nginx server block syntax, and structuring this documentation according to the subject requirements.

## Project Description
Docker is used to isolate and automate services. All configurations and sources are located in `srcs/requirements`. The project relies heavily on the official Docker documentation to implement best practices for containerization.

### Design Choices & Comparisons

**Virtual Machines vs Docker**
Virtual Machines emulate an entire hardware system and run a full guest OS, making them heavy and resource-intensive. Docker containers, on the other hand, share the host system's kernel and isolate the application processes. This makes Docker significantly lighter, faster to boot, and easier to scale.

**Secrets vs Environment Variables**
Environment variables (`.env`) are useful for non-sensitive configuration data (like a domain name) but are visible to anyone inspecting the container's environment. Docker Secrets provide a secure mechanism for handling sensitive data like database passwords. Secrets are mounted directly into the container's memory (`/run/secrets/`) as read-only files, vastly improving security over plain-text variables.

**Docker Network vs Host Network**
Using the host network allows a container to share the host's networking namespace, which poses a security risk. This project explicitly uses an isolated Docker bridge network (`inception`). This ensures containers can only communicate with each other via internal DNS resolution, and only explicitly published ports (like Nginx on 443) are accessible from the host machine.

**Docker Volumes vs Bind Mounts**
Bind mounts map a specific file or directory on the host directly into a container, which can lead to permissions issues and cross-environment inconsistencies. Docker Volumes are managed entirely by Docker within a dedicated storage directory on the host. For this project, we use named Docker volumes mapped to specific host paths (`/home/rbarkhud/data/`) to ensure the persistent storage of database and web files across container restarts and rebuilds.