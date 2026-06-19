FROM		debian:bookworm-slim

RUN			apt-get update \
			&& apt-get install --no-install-recommends -y nginx openssl \
			&& apt-get clean

COPY		./tools/nginx.sh	 /nginx.sh
COPY		./conf/default.conf /etc/nginx/conf.d/default.conf


RUN			chmod +x /nginx.sh

EXPOSE		443/tcp

ENTRYPOINT	["/nginx.sh"]

CMD			["nginx", "-g", "daemon off;"]