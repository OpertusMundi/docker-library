FROM alpine:3.12

RUN apk update && apk add --no-cache pgpool su-exec

RUN mkdir /var/run/pgpool /var/lib/pgpool && \
    chown root:postgres /var/run/pgpool /var/lib/pgpool && chmod 0775 /var/run/pgpool /var/lib/pgpool
COPY --chown=root:postgres pool_hba.conf pgpool.conf.template /etc/pgpool/

ENV POOL_PASSWD_FILE="/etc/pgpool/pool_passwd" \
    PGPOOL_ADMIN_USER="pgpool" \
    PGPOOL_ADMIN_PASSWORD_FILE="/secrets/pgpool-admin-password" \
    MONITOR_USER="monitor" \
    MONITOR_PASSWORD_FILE="/secrets/monitor-password" \
    USER_PASSWORDS_DIR="/secrets/users/" \
    TLS_KEY_FILE="/certs/pgpool.key" \
    TLS_CERT_FILE="/certs/pgpool.crt" \
    BACKEND="localhost:5432,1,server0;localhost:5433,1,server1" \
    NUM_PROCS="32"

COPY docker-entrypoint.sh generate-configuration-for-backend.awk /
RUN chmod 0744 /docker-entrypoint.sh

STOPSIGNAL SIGINT
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["pgpool", "-n", "-D", "-F", "/var/lib/pgpool/pcp.conf"]

