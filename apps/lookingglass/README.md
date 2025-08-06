# ALS - Another Looking Glass Server

ALS 是一个轻量级的网络测试工具，支持以下功能：
- 实时流量显示
- Ping 测试
- Speedtest.net 测速
- iPerf3 测速
- 静态文件下载测速
- Fake Shell
- 节点赞助商信息展示

## 快速部署（1Panel）
1. 在 1Panel 应用商店中添加此应用。
2. 根据需要修改 `data.yml` 中的环境变量。
3. 点击部署即可。

## 环境变量说明

| Key | 默认值 | 描述 |
| --- | --- | --- |
| LISTEN_IP | 0.0.0.0 | 监听 IP |
| HTTP_PORT | 80 | 监听端口 |
| SPEEDTEST_FILE_LIST | 1MB 10MB 100MB 1GB | 静态文件大小列表 |
| LOCATION | 自动获取 | 节点位置文本 |
| PUBLIC_IPV4 | 自动获取 | 节点 IPv4 |
| PUBLIC_IPV6 | 自动获取 | 节点 IPv6 |
| DISPLAY_TRAFFIC | true | 实时流量开关 |
| ENABLE_SPEEDTEST | true | 启用测速功能 |
| UTILITIES_PING | true | 启用 Ping |
| UTILITIES_SPEEDTESTDOTNET | true | 启用 Speedtest.net |
| UTILITIES_FAKESHELL | true | 启用 Fake Shell |
| UTILITIES_IPERF3 | true | 启用 iPerf3 |
| UTILITIES_IPERF3_PORT_MIN | 30000 | iPerf3 端口范围开始 |
| UTILITIES_IPERF3_PORT_MAX | 31000 | iPerf3 端口范围结束 |
| SPONSOR_MESSAGE | 空 | 节点赞助商信息（支持 Markdown/URL/文件） |

## 访问方式
部署完成后，直接访问：
