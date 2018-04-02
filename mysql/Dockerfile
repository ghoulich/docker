# 使用自建的CentOS 6.9基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/ghoulich-centos/centos:6.9

# 镜像维护者
MAINTAINER ghoulich@aliyun.com

# 安装MySQL
RUN rpm -ivh https://repo.mysql.com//mysql57-community-release-el6-11.noarch.rpm
RUN yum install -y mysql-community-server
COPY start.sh /

# 安装supervisor
RUN yum install -y epel-release
RUN rpm --rebuilddb && yum install -y supervisor

# 复制supervisor配置文件
RUN rm -rf /etc/supervisord.conf
COPY supervisord.conf /etc/supervisord.conf

# 清理系统
RUN yum clean all

# 开放3306端口
EXPOSE 3306

# 挂载数据、配置和日志目录
RUN rm -rf /etc/my.cnf /var/log/mysqld.log
VOLUME ["/var/lib/mysql", "/etc/my.cnf", "/var/log/mysqld.log"]

# 自启动supervisor
CMD ["/usr/bin/supervisord"]
