FROM php:7.4-alpine

RUN curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s
RUN curl -o /usr/bin/phpcs https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
	chmod +x /usr/bin/phpcs

RUN apk --update add git && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /tmp

ENTRYPOINT ["/entrypoint.sh"]