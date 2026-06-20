[cite_start]*This project has been created as part of the 42 curriculum by rbarkhud.* [cite: 213]

## Description
[cite_start]This project aims to broaden your knowledge of system administration by using Docker[cite: 222]. [cite_start]The goal is to set up a small infrastructure composed of different services under specific rules[cite: 82]. [cite_start]It implements a LEMP-like stack (Linux, Nginx, MariaDB, PHP) entirely within Docker containers[cite: 85]. [cite_start]Every service runs in its own dedicated container, built from scratch using `debian:bookworm-slim` [cite: 86][cite_start], linked via a custom Docker network [cite: 100][cite_start], and secured using Docker Secrets[cite: 126].

## Instructions
1. [cite_start]Clone the repository[cite: 272].
2. [cite_start]Create a `secrets/` directory containing your password `.txt` files (see USER_DOC.md for details)[cite: 201].
3. [cite_start]Ensure your `srcs/.env` file is populated with your domain and database names[cite: 125, 206].
4. [cite_start]Run `make all` from the root directory to build and launch the infrastructure[cite: 30].
5. Open `https://rbarkhud.42.fr` in your browser.

## Resources
- [Docker Documentation](https://docs.docker.com/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [WordPress Documentation](https://wordpress.org/support/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- [cite_start]**AI Usage:** AI was used to assist in debugging container entrypoint scripts (ensuring idempotency), validating Nginx server block syntax, and structuring this documentation according to the subject requirements[cite: 216].

## Project Description
[cite_start]Docker is used to isolate and automate services[cite: 23]. [cite_start]All configurations and sources are located in `srcs/requirements`[cite: 172]. The project relies heavily on the official Docker documentation to implement best practices for containerization.

### Design Choices & Comparisons

**Virtual Machines vs Docker**
Virtual Machines emulate an entire hardware system and run a full guest OS, making them heavy and resource-intensive. Docker containers, on the other hand, share the host system's kernel and isolate the application processes. [cite_start]This makes Docker significantly lighter, faster to boot, and easier to scale[cite: 221].

**Secrets vs Environment Variables**
[cite_start]Environment variables (`.env`) are useful for non-sensitive configuration data (like a domain name) but are visible to anyone inspecting the container's environment[cite: 124, 125]. [cite_start]Docker Secrets provide a secure mechanism for handling sensitive data like database passwords[cite: 126]. [cite_start]Secrets are mounted directly into the container's memory (`/run/secrets/`) as read-only files, vastly improving security over plain-text variables[cite: 222].

**Docker Network vs Host Network**
Using the host network allows a container to share the host's networking namespace, which poses a security risk. [cite_start]This project explicitly uses an isolated Docker bridge network (`inception`)[cite: 100]. [cite_start]This ensures containers can only communicate with each other via internal DNS resolution, and only explicitly published ports (like Nginx on 443) are accessible from the host machine[cite: 223].

**Docker Volumes vs Bind Mounts**
Bind mounts map a specific file or directory on the host directly into a container, which can lead to permissions issues and cross-environment inconsistencies. [cite_start]Docker Volumes are managed entirely by Docker within a dedicated storage directory on the host[cite: 98]. [cite_start]For this project, we use named Docker volumes mapped to specific host paths (`/home/rbarkhud/data/`) to ensure the persistent storage of database and web files across container restarts and rebuilds[cite: 99, 224].