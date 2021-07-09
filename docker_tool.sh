#!/bin/bash
function print_tips
{
    echo '== Docker Tools ========================================='
    echo "(1) 安装docker和docker-compose"
    echo "(2) 停止所有docker container"
    echo "(3) 删除所有docker container"
    echo "(4) 删除所有docker volume"
    echo "(5) 删除所有docker image"
    echo "(6) 停止并删除所有docer container volume image"
    echo "(7) 卸载docker和docker-compose"
    echo "(d) 显示常用命令示例"
    echo "(Q/q) 退出"
    echo '================================================ Aven7 =='
}

function docker_install
{
    lnx_ver=`uname -a|grep 'Ubuntu'`
    if [ -n "$lnx_ver" ];then
        #安装docker
        echo '========================================================='
        echo '开始安装docker'
        apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
        apt-get update
        apt-get install -y docker-ce docker-ce-cli containerd.io
        apt-cache madison docker-ce
        apt-get install -y docker-ce=5:18.09.1~3-0~ubuntu-xenial
        #安装docker-compose
        echo '开始安装docker-compose'
        sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
        echo '========================================================='
    else
        #安装docker
        echo '========================================================='
        echo '开始安装docker'
        yum install -y yum-utils \
        device-mapper-persistent-data \
        lvm2
        yum-config-manager \
           --add-repo \
            https://download.docker.com/linux/centos/docker-ce.repo
        yum install -y docker-ce docker-ce-cli containerd.io
        #启动docker
        systemctl start docker
        #安装docker-compose
        echo '开始安装docker-compose'
        curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
        chmod +x /usr/local/bin/docker-compose
        echo '========================================================='
    fi
}

function docker_stop_container
{
    echo '========================================================='
    echo '停止所有docker container'
    docker stop $(docker container ls -aq)
    echo '========================================================='
}

function docker_rm_container
{
    echo '========================================================='
    echo '删除所有docker container'
    docker rm $(docker container ls -aq)
    echo '========================================================='
}

function docker_rm_volume
{
    echo '========================================================='
    echo '删除所有docker volume'
    docker volume rm $(docker volume ls -aq)
    echo '========================================================='
}

function docker_rm_image
{
    echo '========================================================='
    echo '删除所有docker image'
    docker rmi $(docker image ls -aq)
    echo '========================================================='
}

function docker_stop_all
{
    echo '========================================================='
    echo '停止所有docker container'
    docker stop $(docker container ls -aq)
    echo '删除所有docker container'
    docker rm $(docker container ls -aq)
    echo '删除所有docker volume'
    docker volume rm $(docker volume ls -aq)
    echo '删除所有docker image'
    docker rmi $(docker image ls -aq)
    echo '========================================================='
}

function docker_command_display
{
    echo '====docker command========================================'
    echo '1. 安装好docker后查看版本：'
    echo 'docker version'
    echo '2. 查看docker进程：'
    echo 'ps -ef | grep docker'
    echo '3. 从registry拉取一个ubuntu镜像：'
    echo 'docker pull ubuntu'   
    echo '4. 运行一个ubuntu镜像，并进入控制台，使用exit退出：'
    echo 'docker run -it ubuntu /bin/bash'  
    echo '5. 列出本地docker的image：'
    echo 'docker image ls'     
    echo '6. 用Dockerfile构建自己的镜像：'
    echo 'docker build -t 你的docker_hub_id/镜像名字 .'   
    echo '例：docker build -t aven7/hello-world .'  
    echo '7. 列出正在运行的容器：'
    echo 'docker container ls' 
    echo '8. 列出所有容器：'
    echo 'docker container ls -a' 
    echo '9. 列出所有卷：'
    echo 'docker volume ls' 
    echo '10. 列出所有网络：'
    echo 'docker network ls' 
    echo '11. 持续化存储方法1：通过-v定义卷别名'
    echo 'docker run -v mysql:/var/lib/mysql' 
    echo '12. 持续化存储方法2：通过-v把本地目录和容器目录对应'
    echo 'docker run -v /home/aaa:/root/aaa centos'    
    echo '13. 端口映射：通过-p和本地端口对应'
    echo 'docker run -p 8080:80 -p 23:223 centos'  
    echo '=========================================================='
    echo ' '
    echo '======docker-compose command=============================='
    echo '51. 创建和开始容器，并在后台运行:'
    echo 'docker-compose up -d'
    echo '52. 停止服务:'
    echo 'docker-compose stop'
    echo '53. 启动服务：'
    echo 'docker-compose start'
    echo '54. 关闭和移除容器，网络，镜像和卷：'
    echo 'docker-compose down'
    echo '55. 列出容器和映像：'
    echo 'docker-compose images'   
    echo '56. 进入wordpress容器执行bash：'
    echo 'docker-compose exec wordpress bash' 
    echo '57. 查看运行的容器：'
    echo 'docker-compose ps'  
    echo '58. 复制扩展运行的容器,例如web：'
    echo 'docker-compose up --scale web=5 -d' 
    echo '=========================================================='
}

function docker_rm
{
    lnx_ver=`uname -a|grep 'Ubuntu'`
    if [ -n "$lnx_ver" ];then
        #卸载系统里存在的docker和docker-compose
        apt-get remove -y  docker docker-engine docker.io containerd runc
        rm -rf /usr/local/bin/docker-compose /usr/bin/docker-compose
    else
        #卸载系统里存在的docker和docker-compose
        yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
        rm -rf /usr/local/bin/docker-compose
    fi
    echo '=========================================================='
    echo '卸载完成！祝您安康'
    echo '=========================================================='
}

while true
do
    print_tips
    read -p "请输入您的选项(1|2|3|4|5|6|7|d|q|Q):" choice
 
    case $choice in
        1)
            docker_install
            ;;
        2)
            docker_stop_container
            ;;
        3)
            docker_rm_container
            ;;
        4)
            docker_rm_volume
            ;;
        5)
            docker_rm_image
            ;;
        6)
            docker_stop_all
            ;;
        7)
            docker_rm
            ;;
        d)
            docker_command_display
            ;;
        q|Q)
            exit
            ;;
        *)
            echo "Error,input only in {1|2|3|4|5|6|7|d|q|Q}"
            ;;
    esac
done