#!/bin/bash
set -e

# 环境变量文件和配置目录
ENV_FILE="$(dirname "$0")/../.env"
CONF_DIR="$(dirname "$0")/../conf"

if [[ ! -f "$ENV_FILE" ]]; then
  echo "❌ 找不到环境变量文件 $ENV_FILE"
  exit 1
fi

set -a
source "$ENV_FILE"
set +a

# 关键变量检查
mkdir -p "$CONF_DIR"

# 生成 nps.conf，使用所有环境变量
cat > "$CONF_DIR/nps.conf" <<EOF
appname = nps
runmode = ${RUN_MODE:-dev}

http_proxy_ip=0.0.0.0
http_proxy_port=${PANEL_APP_PORT_HTTP_PROXY_PORT:-8880}
https_proxy_port=${PANEL_APP_PORT_HTTPS_PROXY_PORT:-4443}
https_just_proxy=${WEB_OPEN_SSL:-false}
https_default_cert_file=${WEB_CERT_FILE:-conf/server.pem}
https_default_key_file=${WEB_KEY_FILE:-conf/server.key}

bridge_type=${BRIDGE_TYPE:-tcp}
bridge_port=${PANEL_APP_PORT_BRIDGE_PORT:-8024}
bridge_ip=${BRIDGE_IP:-0.0.0.0}

public_vkey=${PUBLIC_VKEY}

flow_store_interval=${FLOW_STORE_INTERVAL:-1}
log_level=${LOG_LEVEL:-7}
#log_path=nps.log

#ip_limit=true

#p2p_ip=127.0.0.1
#p2p_port=6000

web_host=${WEB_HOST}
web_username=${WEB_USERNAME:-admin}
web_password=${WEB_PASSWORD}
web_port=${PANEL_APP_PORT_WEB_PORT:-8080}
web_ip=${WEB_IP:-0.0.0.0}
web_base_url=${WEB_BASE_URL:-}
web_open_ssl=${WEB_OPEN_SSL:-false}
web_cert_file=${WEB_CERT_FILE:-conf/server.pem}
web_key_file=${WEB_KEY_FILE:-conf/server.key}
#web_base_url=/nps

auth_key=${AUTH_KEY}
auth_crypt_key=${AUTH_CRYPT_KEY}

#allow_ports=${ALLOW_PORTS:-9001-9009,10001,11000-12000}

allow_user_login=${ALLOW_USER_LOGIN:-true}
allow_user_register=${ALLOW_USER_REGISTER:-false}
allow_user_change_username=${ALLOW_USER_CHANGE_USERNAME:-false}

allow_flow_limit=${ALLOW_FLOW_LIMIT:-true}
allow_rate_limit=${ALLOW_RATE_LIMIT:-true}
allow_tunnel_num_limit=${ALLOW_TUNNEL_NUM_LIMIT:-true}
allow_local_proxy=${ALLOW_LOCAL_PROXY:-true}
allow_connection_num_limit=${ALLOW_CONNECTION_NUM_LIMIT:-true}
allow_multi_ip=${ALLOW_MULTI_IP:-false}
system_info_display=${SYSTEM_INFO_DISPLAY:-true}

http_cache=${HTTP_CACHE:-true}
http_cache_length=${HTTP_CACHE_LENGTH:-100}
EOF

# 生成 npc.conf，使用所有环境变量
cat > "$CONF_DIR/npc.conf" <<EOF
[common]
server_addr=${NPC_SERVER_ADDR:-127.0.0.1}:${PANEL_APP_PORT_BRIDGE_PORT:-8024}
conn_type=${NPC_CONN_TYPE:-tcp}
vkey=${PUBLIC_VKEY}
auto_reconnection=${NPC_AUTO_RECONNECTION:-true}
crypt=${NPC_CRYPT:-true}
compress=${NPC_COMPRESS:-true}
remark=${NPC_REMARK:-nps}

[web-admin]
mode=${NPC_WEB_ADMIN_MODE:-https}
host=${WEB_HOST}
target_addr=127.0.0.1:${PANEL_APP_PORT_WEB_PORT:-8080}

[web-file]
mode=${NPC_WEB_FILE_MODE:-http}
host=file.${WEB_HOST#*.}
target_addr=127.0.0.1:${NPC_FILE_SERVER_PORT:-8081}

[file]
mode=${NPC_FILE_MODE:-file}
server_port=${NPC_FILE_SERVER_PORT:-8081}
local_path=${NPC_FILE_LOCAL_PATH:-/file/}
strip_pre=${NPC_FILE_STRIP_PRE:-/}
EOF

echo "✅ 配置文件已生成在 $CONF_DIR 下"
