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

# 生成 nps.conf，完整且包含你给出的所有字段
cat > "$CONF_DIR/nps.conf" <<EOF
appname = nps
runmode = ${RUN_MODE}

http_proxy_ip=0.0.0.0
http_proxy_port=${PANEL_APP_PORT_HTTP_PROXY_PORT}
https_proxy_port=${PANEL_APP_PORT_HTTPS_PROXY_PORT}
https_just_proxy=${Web_OPEN_SSL:-false}
https_default_cert_file=conf/server.pem
https_default_key_file=conf/server.key

bridge_type=tcp
bridge_port=${PANEL_APP_PORT_BRIDGE_PORT}
bridge_ip=0.0.0.0

public_vkey=${PUBLIC_VKEY}

flow_store_interval=1
log_level=7
#log_path=nps.log

#ip_limit=true

#p2p_ip=127.0.0.1
#p2p_port=6000

web_host=${WEB_HOST}
web_username=${WEB_USERNAME}
web_password=${WEB_PASSWORD}
web_port=${PANEL_APP_PORT_WEB_PORT}
web_ip=0.0.0.0
web_base_url=
web_open_ssl=${Web_OPEN_SSL:-false}
web_cert_file=conf/server.pem
web_key_file=conf/server.key
#web_base_url=/nps

auth_key=${AUTH_KEY}
auth_crypt_key=${AUTH_CRYPT_KEY}

#allow_ports=${ALLOW_PORTS}

allow_user_login=true
allow_user_register=true
allow_user_change_username=true

allow_flow_limit=true
allow_rate_limit=true
allow_tunnel_num_limit=true
allow_local_proxy=true
allow_connection_num_limit=true
allow_multi_ip=false
system_info_display=true

http_cache=true
http_cache_length=100
EOF

# 生成 npc.conf
cat > "$CONF_DIR/npc.conf" <<EOF
[common]
server_addr=127.0.0.1:${PANEL_APP_PORT_BRIDGE_PORT}
conn_type=tcp
vkey=${PUBLIC_VKEY}
auto_reconnection=true
crypt=true
compress=true
remark=nps

[web-admin]
mode=https
host=${WEB_HOST}
target_addr=127.0.0.1:${PANEL_APP_PORT_WEB_PORT}

[web-file]
mode=http
host=file.${WEB_HOST#*.}
target_addr=127.0.0.1:8081

[file]
mode=file
server_port=8081
local_path=/file/
strip_pre=/
EOF

echo "✅ 配置文件已生成在 $CONF_DIR 下"
