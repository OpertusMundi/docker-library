#!/bin/sh
set -e

# Check environment

if [ ! -f "${PGPOOL_ADMIN_PASSWORD_FILE}" ]; then
    echo "The file with the admin password for PgPool (PGPOOL_ADMIN_PASSWORD_FILE) is missing!" 1>&2
    exit 1
fi

# Generate credentials for management interface (pcp.conf)

echo "${PGPOOL_ADMIN_USER}:"$(pg_md5 "$(cat $PGPOOL_ADMIN_PASSWORD_FILE)") >>/var/lib/pgpool/pcp.conf

#
# Generate pool_passwd from directory of user credentials
#

if [ ! -f ${POOL_PASSWD_FILE} ]; then
    touch ${POOL_PASSWD_FILE} 
    chown root:postgres ${POOL_PASSWD_FILE} && chmod g=r,o= ${POOL_PASSWD_FILE}
    if [ -d "${USER_PASSWORDS_DIR}" ]; then
        for username in  $(ls -1 ${USER_PASSWORDS_DIR}); do
            pg_md5 --md5auth --username ${username} "$(cat ${USER_PASSWORDS_DIR%/}/${username})"
        done
    fi
fi

#
# Generate pgpool.conf
#

touch /etc/pgpool/pgpool.conf
chmod g=r,o= /etc/pgpool/pgpool.conf && chown root:postgres /etc/pgpool/pgpool.conf

if [ -z "${BACKEND}" ]; then
    echo "No configuration for backend!" 1>&2
    exit 1
fi

backend_configuration_escaped=$(echo ${BACKEND} | tr ';' '\n' | awk -F ',' -f /generate-configuration-for-backend.awk | \
    sed ':a;N;$!ba;s/\n/\\n/g')

monitor_password="$(cat ${MONITOR_PASSWORD_FILE})"

sed \
    -e "s/\${NUM_PROCS}/${NUM_PROCS:-32}/" \
    -e "s~\${POOL_PASSWD_FILE}~${POOL_PASSWD_FILE}~" \
    -e "s~^ssl[[:blank:]]*=[[:blank:]]*off~ssl = on~" \
    -e "s~\${TLS_KEY_FILE}~${TLS_KEY_FILE}~" \
    -e "s~\${TLS_CERT_FILE}~${TLS_CERT_FILE}~" \
    -e "s/\${MONITOR_USER}/${MONITOR_USER}/" \
    -e "s/\${MONITOR_PASSWORD}/${monitor_password}/" \
    -e "/^#[[:blank:]]\+[-][[:blank:]]\+Backend/a "'\\n'"${backend_configuration_escaped}" \
    /etc/pgpool/pgpool.conf.template > /etc/pgpool/pgpool.conf

#
# Start
#

exec su-exec postgres $@
