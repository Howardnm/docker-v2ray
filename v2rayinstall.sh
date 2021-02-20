#!/bin/bash

basepath=$(cd `dirname $0`; pwd)
	echo "检查Docker......"
	docker -v
    if [ $? -eq  0 ]; then
        echo "检查到Docker已安装!"
    else
    	echo "安装docker环境..."
        curl -sSL https://get.daocloud.io/docker | sh
        systemctl start docker
        systemctl enable docker
        echo "安装docker环境...安装完成!"
    fi

read -t 30 -p "是否安装v2ray? y or n :" isMove
if [ "${isMove}" = "y" ]; then
wget -P /etc/v2ray/ https://raw.githubusercontent.com/Howardnm/vtworay/main/config_mkcp_detour.json 
wget -P /etc/v2ray/ https://raw.githubusercontent.com/Howardnm/vtworay/main/config_tcp.json 
wget -P /etc/v2ray/ https://raw.githubusercontent.com/Howardnm/vtworay/main/config_mkcp.json
docker run -d --name v2ray_mkcp --restart=always -v /etc/v2ray:/etc/v2ray -p 52001:52001 -p 52001:52001/udp v2fly/v2fly-core  v2ray -config=/etc/v2ray/config_mkcp.json
docker run -d --name v2ray_tcp --restart=always -v /etc/v2ray:/etc/v2ray -p 51001:51001 -p 51001:51001/udp v2fly/v2fly-core  v2ray -config=/etc/v2ray/config_tcp.json
elif [ "${isMove}" = "n" ]; then
echo "已退出 !"
fi
