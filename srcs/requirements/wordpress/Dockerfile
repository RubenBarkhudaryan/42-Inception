FROM		debian:bookworm-slim

RUN			mkdir -p /var/www/html

RUN			apt-get update && \
			apt-get upgrade -y && \
			apt-get install -y \
				php8.2 \
				php8.2-fpm \
				php8.2-mysql \
				php8.2-curl \
				php8.2-gd \
				php8.2-mbstring \
				php8.2-xml \
				php8.2-zip \
				php8.2-intl \
				php8.2-soap \
				php8.2-bcmath \
				php8.2-json \
				php8.2-cli \
				php8.2-readline \
				php8.2-ldap \
				php8.2-tideways \
				curl \
				wget \
				unzip \
			&& apt-get clean && \
			rm -rf /var/lib/apt/lists/*

RUN			sed -i "s/listen = .*/listen = 0.0.0.0:9000/" /etc/php/8.2/fpm/pool.d/www.conf

RUN			curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
			&& chmod +x wp-cli.phar \
			&& mv wp-cli.phar /usr/local/bin/wp

COPY		./tools/wordpress.sh /wordpress.sh

COPY		./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN			chmod +x /wordpress.sh

EXPOSE		9000

ENTRYPOINT	["/wordpress.sh"]

CMD			["php-fpm8.2", "-F"]