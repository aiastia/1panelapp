[c4] README.md
# MetaTube 应用说明

一句话简介：汇聚电影元数据的轻量服务



## 部署后第一步
部署完成后，浏览器访问 `http://<服务器IP>:8080` 即可打开 MetaTube 首页，目前无需登录即可使用。

## 反向代理（可选）
如需通过 1Panel「一键网站」暴露域名，在「反向代理」页新建路由，填写端口 8080 即可自动 HTTPS。

## 官方文档 & 更新办法
官方 GitHub：https://github.com/metatube-community/metatube-server  
更新：在应用管理→编辑，切换镜像版本并重建即可。

## 进阶折腾
- 自定义数据库路径：修改映射卷目录即可。
- READ-ONLY 模式：可在容器启动命令追加 `-readonly`。
END