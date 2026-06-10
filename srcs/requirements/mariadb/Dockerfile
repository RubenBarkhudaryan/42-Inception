FROM		debian:bookworm-slim

RUN			apt-get update && \
			apt-get upgrade -y && \
			apt-get install -y \
			mariadb-server \
			mariadb-client && \
			apt-get clean && \
			rm -rf /var/lib/apt/lists/*

COPY		./tools/script.sh /script.sh

COPY		./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN			chmod +x /script.sh

EXPOSE		3306

ENTRYPOINT	["/script.sh"]

CMD			["mysqld"]