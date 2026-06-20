NAME    =   inception
ENV     =   ./srcs/.env
# Using $(USER) is safer than ~ for cross-environment compatibility
DIRS    =   /home/$(USER)/data/mariadb /home/$(USER)/data/wordpress

all: create_dirs up

create_dirs:
	@mkdir -p ${DIRS}

up:
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

# Added --volumes to down to ensure volumes are detached
hard_down:
	@docker compose -f ./srcs/docker-compose.yml down -v

start:
	@docker compose -f ./srcs/docker-compose.yml start

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

# clean now depends on down to ensure nothing is running while we delete
clean: down
	@sudo rm -rf ${DIRS}
	@docker volume rm srcs_wordpress-volume srcs_mariadb-volume 2>/dev/null || true

# fclean does a total wipe of images, containers, networks, and cache
fclean: clean
	@docker system prune -af --volumes 2>/dev/null || true

re: fclean all

.PHONY: all re up down hard_down start stop create_dirs clean fclean