FROM		debian:bookworm-slim

RUN			apt-get update \
			&& apt-get install -y nginx openssl \
			&& apt-get clean

COPY		./tools/script.sh .

RUN			chmod u+x script.sh

EXPOSE		443/tcp

ENTRYPOINT	["./script.sh"]

CMD			["nginx", "-g", "daemon off;"]