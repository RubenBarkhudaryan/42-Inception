FROM		debian:bookworm-slim

RUN			apt-get update && \
			apt-get install --no-install-recommends -y \
			mariadb-server \
			mariadb-client && \
			apt-get clean && \
			rm -rf /var/lib/apt/lists/*

COPY		./tools/mariadb.sh /mariadb.sh

COPY		./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN			chmod +x /mariadb.sh

EXPOSE		3306

ENTRYPOINT	["/mariadb.sh"]

CMD			["mysqld"]