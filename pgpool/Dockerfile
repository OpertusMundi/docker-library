FROM redhat/ubi8:8.8

ARG POSTGRES_MAJOR_VERSION="15"

RUN dnf -y update && \
  dnf -y install https://www.pgpool.net/yum/rpms/4.4/redhat/rhel-9-x86_64/pgpool-II-release-4.4-1.noarch.rpm && \
  dnf -y install procps pgpool-II-pg${POSTGRES_MAJOR_VERSION} && \
  dnf clean all

RUN gpg --batch --keyserver hkps://keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
  curl -L -o /opt/gosu https://github.com/tianon/gosu/releases/download/1.16/gosu-amd64 && \
  curl -L -o /opt/gosu.asc https://github.com/tianon/gosu/releases/download/1.16/gosu-amd64.asc && \
  gpg --batch --verify /opt/gosu.asc /opt/gosu && \
  install /opt/gosu /usr/local/bin/ -m 0700 -v

COPY --chown=postgres:postgres pool_hba.conf pgpool.conf.template /etc/pgpool-II/

ENV POOL_PASSWD_FILE="/etc/pgpool-II/pool_passwd" \
    POOL_HBA_FILE="/etc/pgpool-II/pool_hba.conf" \
    PCP_SOCKET_DIR="/var/run/pgpool" \
    PGPOOL_ADMIN_USER="pgpool" \
    PGPOOL_ADMIN_PASSWORD_FILE="/secrets/pgpool-admin-password" \
    PGPOOLKEYFILE="/secrets/pgpool-key" \
    AUTH_METHOD="md5" \
    MONITOR_USER="monitor" \
    MONITOR_PASSWORD_FILE="/secrets/monitor-password" \
    USER_PASSWORDS_DIR="/secrets/users/" \
    TLS_KEY_FILE="/certs/pgpool.key" \
    TLS_CERT_FILE="/certs/pgpool.crt" \
    NUM_PROCS="32" \
    POOL_SIZE="4" \
    CHILD_LIFE_TIME="5min" \
    CLIENT_IDLE_LIMIT="0" \
    LOAD_BALANCE="on" \
    HEALTH_CHECK_PERIOD="90" \
    HEALTH_CHECK_MAX_RETRIES="3" \
    HEALTH_CHECK_RETRY_DELAY="15" \
    BACKEND_0_HOST="localhost" \
    BACKEND_0_PORT="5432" \
    BACKEND_0_WEIGHT="1" \
    BACKEND_0_NAME="server1"

COPY docker-entrypoint.sh /
RUN chmod 0744 /docker-entrypoint.sh

RUN mkdir /var/lib/pgpool/ /var/lib/pgsql /var/log/pgpool && \
  chown -v postgres:postgres /var/lib/pgpool/ /var/lib/pgsql /var/log/pgpool

STOPSIGNAL SIGINT
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["pgpool", "-n", "-D", "-F", "/var/lib/pgpool/pcp.conf"]

