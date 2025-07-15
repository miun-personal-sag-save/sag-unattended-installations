#!/bin/sh

# Section 0 - Framework Import
if ! command -V "logI" 2>/dev/null | grep function >/dev/null; then
  echo "sourcing commonFunctions.sh ..."
  if [ ! -f "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh" ]; then
    echo "Panic, framework issue! File ${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh does not exist. SUIF_CACHE_HOME=${SUIF_CACHE_HOME}"
    exit 155
  fi
  # shellcheck source=/dev/null
  . "${SUIF_CACHE_HOME}/01.scripts/commonFunctions.sh"
fi

# Section 1 - the caller MUST provide

if [ -z ${SUIF_SETUP_TEMPLATE_MSR_LICENSE_FILE+x} ]; then
    logE "User must provide a valid MSR license file in the environment variable SUIF_SETUP_TEMPLATE_MSR_LICENSE_FILE"
    exit 1
fi

if [ ! -f "${SUIF_SETUP_TEMPLATE_MSR_LICENSE_FILE}" ]; then
    logE "User must provide a valid MSR license file, the declared file ${SUIF_SETUP_TEMPLATE_MSR_LICENSE_FILE} does not exist!"
    exit 2
fi

# # Mandatory - check TODO
# ${SUIF_INSTALL_IMAGE_FILE}
# ${SUIF_INSTALL_MSR_CORE_JDBC_POOL_USER_PASSWORD}
# ${SUIF_INSTALL_MSR_CORE_JDBC_POOL_USER_NAME}
# ${SUIF_INSTALL_MSR_CDS_DB_USER_PASSWORD}
# ${SUIF_INSTALL_MSR_CDS_DB_USER_NAME}

# Section 2 - the caller MAY provide

export SUIF_INSTALL_TIME_ADMIN_PASSWORD="${SUIF_INSTALL_TIME_ADMIN_PASSWORD:-manage}"
export SUIF_INSTALL_INSTALL_DIR="${SUIF_INSTALL_INSTALL_DIR:-/opt/webmethods}"

export SUIF_INSTALL_DECLARED_HOSTNAME="${SUIF_INSTALL_DECLARED_HOSTNAME:-localhost}"
## MSR related
export SUIF_INSTALL_MSR_MAIN_HTTP_PORT="${SUIF_INSTALL_MSR_MAIN_HTTP_PORT:-5555}"
export SUIF_INSTALL_MSR_MAIN_HTTPS_PORT="${SUIF_INSTALL_MSR_MAIN_HTTPS_PORT:-5553}"
export SUIF_INSTALL_MSR_DIAGS_HTTP_PORT="${SUIF_INSTALL_MSR_DIAGS_HTTP_PORT:-9999}"
export SUIF_INSTALL_MSR_CORE_JDBC_POOL_NAME="${SUIF_INSTALL_MSR_CORE_JDBC_POOL_NAME:-iscore}"
export SUIF_INSTALL_MSR_CDS_DB_POOL_NAME="${SUIF_INSTALL_MSR_CDS_DB_POOL_NAME:-cds}"

# Section 3 - Computed values

SUIF_SETUP_TEMPLATE_MSR_LICENSE_UrlEncoded=$(urlencode "${SUIF_SETUP_TEMPLATE_MSR_LICENSE_FILE}")
export SUIF_SETUP_TEMPLATE_MSR_LICENSE_UrlEncoded

SUIF_INSTALL_MSR_CORE_DB_URLENCODED_JDBC_CONN=$(urlencode "${SUIF_INSTALL_MSR_CORE_DB_JDBC_CONN}")
export SUIF_INSTALL_MSR_CORE_DB_URLENCODED_JDBC_CONN

SUIF_INSTALL_MSR_CDS_DB_URLENCODED_JDBC_CONN=$(urlencode "${SUIF_INSTALL_MSR_CDS_DB_JDBC_CONN}")
export SUIF_INSTALL_MSR_CDS_DB_URLENCODED_JDBC_CONN

# Example JDBC Connection value jdbc:wm:oracle://<server>:<port>;serviceName=<service>[;<option>=<value>]...
# Example JDBC Connection URL Encoded value jdbc%3Awm%3Aoracle%3A%2F%2F%3Cserver%3E%3A%3Cport%3E%3BserviceName%3D%3Cservice%3E%5B%3B%3Coption%3E%3D%3Cvalue%3E%5D...


# Section 4 - Constants

export SUIF_CURRENT_SETUP_TEMPLATE_PATH="MSR/1015/cu_cds_jdbc_mq"
logI "Template environment sourced successfully"
logEnv4Debug
