# ChatGPT-Next-Web 部署指南

## 功能特性
- 支持 GPT-3.5/4 模型切换
- 自定义 OpenAI API 代理
- 多对话管理

## 快速开始
1. 安装时需填写：
   - `OpenAI API Key`（必填）
   - `访问密码`（可选，留空则开放访问）
2. 默认访问地址：`http://服务器IP:${HOST_PORT}`

## 环境变量说明
| 变量名               | 作用                         | 示例值                  |
|----------------------|------------------------------|-------------------------|
| `OPENAI_API_KEY`     | OpenAI官方API密钥            | sk-xxx...xxx           |
| `CODE`               | 网页端访问密码               | 123456                 |
| `BASE_URL`           | 自定义API代理地址            | https://your-proxy.com |
| `HIDE_USER_API_KEY`  | 隐藏用户密钥输入框           | true/false             |

## 安全建议
1. 强烈建议设置 `CODE` 访问密码
2. 如需公开访问，请配置Nginx反向代理并启用HTTPS
3. 定期轮换API密钥

## 高级配置
通过修改 `docker-compose.yml` 可添加：
```yaml
environment:
  - DISABLE_GPT4=1  # 完全禁用GPT-4
  - PROXY_URL=http://your-proxy:8080
```