#!/bin/sh

config_file="/usr/local/tomcat/webapps/xxl-job/WEB-INF/classes/xxl-job-admin.properties"

until [ $# -eq 0 ]
do
    case "$1" in
        --mysql-host)
            sed -i "3s/localhost/$2/g" $config_file
            shift 2;;
        --mysql-port)
            sed -i "3s/3306/$2/g" $config_file
            shift 2;;
        --mysql-user)
            sed -i "4s/root/$2/g" $config_file
            shift 2;;
        --mysql-password)
            sed -i "5s/root_pwd/$2/g" $config_file
            shift 2;;
        --mail-host)
            sed -i "8s/smtp.163.com/$2/g" $config_file
            shift 2;;
        --mail-port)
            sed -i "9s/25/$2/g" $config_file
            shift 2;;
        --mail-username)
            sed -i "10s/ovono802302@163.com/$2/g" $config_file
            shift 2;;
        --mail-password)
            sed -i "11s/asdfzxcv/$2/g" $config_file
            shift 2;;
        --mail-sendnick)
            sed -i "12s/《任务调度平台XXL-JOB》/$2/g" $config_file
            shift 2;;
        --login-username)
            sed -i "15s/admin/$2/g" $config_file
            shift 2;;
        --login-password)
            sed -i "16s/123456/$2/g" $config_file
            shift 2;;
        --access-token)
            sed -i "19s/xxl.job.accessToken=/xxl.job.accessToken=$2/g" $config_file
            shift 2;;
        *) echo " unknow prop $1";shift;;
    esac
done

echo "===================================="
cat $config_file
echo "===================================="

/usr/local/tomcat/bin/jsvc -stop org.apache.catalina.startup.Bootstrap

/usr/local/tomcat/bin/jsvc -nodetach -classpath /usr/local/tomcat/bin/bootstrap.jar:/usr/local/tomcat/bin/tomcat-juli.jar -outfile /usr/local/tomcat/logs/catalina.out -errfile /usr/local/tomcat/logs/catalina.err -Dcatalina.home=/usr/local/tomcat -Dcatalina.base=/usr/local/tomcat -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Djava.util.logging.config.file=/usr/local/tomcat/conf/logging.properties org.apache.catalina.startup.Bootstrap
