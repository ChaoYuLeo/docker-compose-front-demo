#!/bin/bash

# 运行docker-compose，开始构建镜像，启动容器
docker-compose up --build -d
# 清除构建后的镜像残留
docker image prune -f

