# 使用自建的CentOS 6.9基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/ghoulich-centos/centos:6.9

# 镜像维护者
MAINTAINER ghoulich@aliyun.com

# 添加Nginx镜像源
COPY nginx.repo /etc/yum.repos.d/
RUN rpm --import http://nginx.org/keys/nginx_signing.key

# 安装Nginx
RUN yum install -y epel-release
RUN rpm --rebuilddb && yum install -y nginx supervisor
RUN mkdir -p /var/lib/nginx
COPY start.sh /
COPY supervisord.conf /etc/supervisord.conf

# 清理系统
RUN yum clean all

# 开放端口
EXPOSE 80

# 挂载数据、配置和日志目录
VOLUME ["/var/lib/nginx", "/etc/nginx", "/var/log/nginx"]

# 自动启动Nginx
CMD ["/usr/bin/supervisord"]
