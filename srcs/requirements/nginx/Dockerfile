FROM		debian:bookworm-slim

RUN			apt-get update \
			&& apt-get install -y nginx openssl \
			&& apt-get clean

COPY		./tools/script.sh	 /script.sh
COPY		./conf/default.conf /etc/nginx/nginx.conf

RUN			chmod +x script.sh

EXPOSE		443/tcp

ENTRYPOINT	["/script.sh"]

CMD			["nginx", "-g", "daemon off;"]