# 使用自建的CentOS 6.9基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/ghoulich-centos/centos:6.9

# 镜像维护者
MAINTAINER ghoulich@aliyun.com

# 下载依赖包
RUN yum install -y epel-release
RUN rpm --rebuilddb && yum install -y wget supervisor
COPY supervisord.conf /etc/supervisord.conf

# 安装Redis
RUN rpm -ivh http://rpms.famillecollet.com/enterprise/6/remi/x86_64/remi-release-6.9-2.el6.remi.noarch.rpm
RUN yum --enablerepo=remi install -y redis
RUN mkdir -p /etc/redis && mv /etc/{redis.conf,redis-sentinel.conf} /etc/redis
COPY start.sh /

# 清理系统
RUN yum clean all

# 开放端口
EXPOSE 6379

# 挂载数据、配置和日志目录
VOLUME ["/var/lib/redis", "/etc/redis", "/var/log/redis"]

# 自动启动redis
CMD ["/usr/bin/supervisord"]
