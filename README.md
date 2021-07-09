# Docker-Tools使用手册

#### 下载地址

```shell
wget http://download.swarmeth.org/docker/docker_tool.sh && chmod a+x docker_tool.sh && ./docker_tool.sh
```

#### 使用手册

```shell
== Docker Tools =========================================
(1) 安装docker和docker-compose
(2) 停止所有docker container
(3) 删除所有docker container
(4) 删除所有docker volume
(5) 删除所有docker image
(6) 停止并删除所有docer container volume image
(7) 卸载docker和docker-compose
(d) 显示常用命令示例
(Q/q) 退出
================================================ Aven7 ==
请输入您的选项(1|2|3|4|5|6|7|d|q|Q):
```

查看常用命令d

```shell
请输入您的选项(1|2|3|4|5|6|7|d|q|Q):d
====docker command========================================
1. 安装好docker后查看版本：
docker version
2. 查看docker进程：
ps -ef | grep docker
3. 从registry拉取一个ubuntu镜像：
docker pull ubuntu
4. 运行一个ubuntu镜像，并进入控制台，使用exit退出：
docker run -it ubuntu /bin/bash
5. 列出本地docker的image：
docker image ls
6. 用Dockerfile构建自己的镜像：
docker build -t 你的docker_hub_id/镜像名字 .
例：docker build -t aven7/hello-world .
7. 列出正在运行的容器：
docker container ls
8. 列出所有容器：
docker container ls -a
9. 列出所有卷：
docker volume ls
10. 列出所有网络：
docker network ls
11. 持续化存储方法1：通过-v定义卷别名
docker run -v mysql:/var/lib/mysql
12. 持续化存储方法2：通过-v把本地目录和容器目录对应
docker run -v /home/aaa:/root/aaa centos
13. 端口映射：通过-p和本地端口对应
docker run -p 8080:80 -p 23:223 centos
==========================================================
 
======docker-compose command==============================
51. 创建和开始容器，并在后台运行:
docker-compose up -d
52. 停止服务:
docker-compose stop
53. 启动服务：
docker-compose start
54. 关闭和移除容器，网络，镜像和卷：
docker-compose down
55. 列出容器和映像：
docker-compose images
56. 进入wordpress容器执行bash：
docker-compose exec wordpress bash
57. 查看运行的容器：
docker-compose ps
57. 复制扩展运行的容器,例如web：
docker-compose up --scale web=5 -d
==========================================================
```
