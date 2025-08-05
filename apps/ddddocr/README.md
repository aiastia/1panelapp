# ddddOCR Server 部署指南

## 功能简介
基于 [ddddOCR](https://github.com/sml2h3/ddddocr) 的即用型验证码识别API服务，支持：
- 数字/字母/汉字验证码识别
- 滑块缺口识别
- 点选文字识别

## 快速开始
1. 在1Panel应用市场安装本应用
2. 默认端口 `9898`（可在安装时修改）
3. 安装完成后通过以下方式测试：

```bash
curl -X POST http://<服务器IP>:${WEB_PORT}/recognize \
  -F "image=@/path/to/captcha.png"
```

## API接口说明
| 端点            | 方法 | 参数          | 返回值示例           |
|-----------------|------|---------------|----------------------|
| `/recognize`    | POST | image: 图片文件 | `{"result": "A3B9"}` |
| `/health`       | GET  | -             | `{"status": "ok"}`   |

## 数据路径
- 容器内工作目录：`/app`
- 日志查看：`docker logs ${CONTAINER_NAME}`

## 常见问题
Q: 识别率低怎么办？  
A: 建议上传更清晰的验证码样本，或联系开发者训练专用模型。