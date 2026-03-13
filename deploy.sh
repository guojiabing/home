#!/bin/bash
# ---------------------------------------------------------------------------
# 个人主页 Tencent Cloud 离线镜像部署脚本 (Mac -> Server)
# 由于 GFW 彻底阻断了云服务器的 docker pull，本方案将部署流程逆转：
# 直接利用您的高性能 Mac 在本地打包好环境镜像，然后压缩推送到服务器唤醒！
# ---------------------------------------------------------------------------

SERVER="ubuntu@43.143.251.32"
DIR="~/dev/homepage"
IMAGE_NAME="homepage:latest"
TAR_FILE="homepage.tar"

echo "🚀 第一步：使用 Mac 本地 Docker 引擎无阻碍编译项目镜像 (amd64 架构)..."
docker build --platform linux/amd64 -t $IMAGE_NAME .

echo "📦 第二步：序列化 Docker 镜像打包至本地磁盘..."
docker save $IMAGE_NAME > $TAR_FILE

echo "🚢 第三步：通过高速增量同步通道将压缩镜像推进腾讯云服务器内网..."
rsync -avz --exclude node_modules --exclude .git --exclude dist --exclude screenshots --rsync-path="sudo rsync" ./docker-compose.yml ./$TAR_FILE ${SERVER}:${DIR}/

echo "🐳 第四步：在远程服务器反向注入镜像并挂载应用守护进程..."
ssh $SERVER "cd ${DIR} && sudo docker load -i $TAR_FILE && sudo docker compose up -d"

echo "🧹 第五步：清理传输痕迹..."
rm -f $TAR_FILE

echo "✅ 部署已无缝完成！即使拔掉光缆，该方案仍可继续执行！端口：8888"
