#!/bin/bash

# 停止容器并删除由docker-compose up 创建的container(容器)、networks、volumes、images（镜像）
docker-compose down --volumes
