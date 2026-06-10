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

# package php8.2-json has no installation candidate.

# The php8.2-json package is not available in the Debian Bookworm repositories because, starting from PHP 8.0, the JSON extension is included in the core PHP distribution and does not require a separate package. Therefore, you can safely remove the php8.2-json package from your installation command, as it is already part of the PHP core and will be available when you install PHP 8.2.

# so what ?

