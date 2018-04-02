# 使用自建的CentOS 6.9基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/ghoulich-centos/centos:6.9

# 镜像维护者
MAINTAINER ghoulich@aliyun.com

# 安装依赖包
RUN yum install -y epel-release
RUN rpm --rebuilddb && yum install -y supervisor wget java-1.8.0-openjdk tar
COPY supervisord.conf /etc/supervisord.conf

# 安装zookeeper
RUN wget http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.11/zookeeper-3.4.11.tar.gz
RUN tar xvzf zookeeper-3.4.11.tar.gz
RUN mv zookeeper-3.4.11 /usr/local/zookeeper
RUN rm -rf zookeeper-3.4.11.tar.gz
ENV ZOO_LOG_DIR /usr/local/zookeeper/logs
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-3.b14.el6_9.x86_64/jre

# 清理系统
RUN yum clean all

# 开放端口
EXPOSE 2181

# 挂载数据、配置和日志目录
VOLUME ["/var/lib/zookeeper", "/usr/local/zookeeper/conf", "/usr/local/zookeeper/logs"]

# 自动启动zookeeper
CMD ["/usr/bin/supervisord"]
