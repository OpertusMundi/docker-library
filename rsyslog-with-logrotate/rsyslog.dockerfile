# vim: set syntax=dockerfile:

FROM alpine:3.13

RUN apk update \
    && apk add --no-cache tzdata rsyslog rsyslog-mmpstrucdata logrotate

# Use a variant of crond that can be run as non-root user: https://github.com/aptible/supercronic
# see also https://github.com/aptible/supercronic/releases
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.1.12/supercronic-linux-amd64 \
    SUPERCRONIC_SHA1SUM=048b95b48b708983effb2e5c935a1ef8483d9e3e

RUN  wget "${SUPERCRONIC_URL}" -q -O /usr/local/bin/supercronic \
	&& echo "${SUPERCRONIC_SHA1SUM}  /usr/local/bin/supercronic" | sha1sum -c - \
 	&& chmod a+x /usr/local/bin/supercronic

RUN addgroup -g 1000 rsyslog \
	&& adduser -D -G rsyslog -u 1000 -h /var/lib/rsyslog rsyslog

VOLUME [ "/var/log/" ]

CMD ["rsyslogd", "-n"]
