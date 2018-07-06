# 从Docker-Hub上拉取node镜像 别名为 builder
FROM node as builder
# 设置git的ssl认证为false
RUN git config --global http.sslVerify false
# 修改npm源，加快包安装速度
RUN npm config set registry http://registry.npm.taobao.org/
# 进入root目录
WORKDIR /root
# 克隆前端项目（这里以react-todo-list项目为例）
RUN git clone https://github.com/kweiberth/react-todo-list.git
# 进入项目目录
WORKDIR /root/react-todo-list
# 安装项目依赖，打包 && 将打包好的文件拷贝到release目录
RUN npm install && npm run build $AREA &&  cp -r ./dist /release


# 拉取nginx镜像，这里用的alpine是一个精简的linux系统
FROM nginx:alpine
# 从别名为builder的镜像中将项目构建包拷贝到nginx镜像的/html目录
COPY --from=builder /release /html
# 将该目录下的nginx.conf配置文件添加到nginx镜像内
ADD ./nginx.conf /etc/nginx/conf.d/default.conf

