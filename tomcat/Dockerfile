# 使用自建的CentOS 6.9基础镜像
FROM registry.cn-hangzhou.aliyuncs.com/ghoulich-centos/centos:6.9

# 镜像维护者
MAINTAINER ghoulich@aliyun.com

# 安装依赖包
RUN rpm --rebuilddb && yum install -y epel-release
RUN rpm --rebuilddb && yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel gcc autoconf wget supervisor tar

# 下载安装Tomcat
RUN wget http://mirrors.advancedhosters.com/apache/tomcat/tomcat-9/v9.0.6/bin/apache-tomcat-9.0.6.tar.gz
RUN tar xvzf apache-tomcat-9.0.6.tar.gz
RUN rm -rf apache-tomcat-9.0.6.tar.gz
RUN mv apache-tomcat-9.0.6 /usr/local/tomcat

# 配置环境变量
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-3.b14.el6_9.x86_64
ENV CATALINA_HOME /usr/local/tomcat

# 编译安装jsvc
RUN cd /usr/local/tomcat/bin && tar xvfz commons-daemon-native.tar.gz
RUN cd /usr/local/tomcat/bin/commons-daemon-1.1.0-native-src/unix/ && ./configure && make
RUN cp /usr/local/tomcat/bin/commons-daemon-1.1.0-native-src/unix/jsvc /usr/local/tomcat/bin/
COPY supervisord.conf /etc/supervisord.conf

# 清理系统
RUN yum clean all

# 开放端口
EXPOSE 8080

# 挂载数据、配置和日志目录
VOLUME ["/usr/local/tomcat/webapps", "/usr/local/tomcat/conf", "/usr/local/tomcat/logs"]

# 自动启动Tomcat
CMD ["/usr/bin/supervisord"]
