FROM centos:6.7
MAINTAINER Shigeaki Nakamura

RUN /bin/cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

RUN rpm -Uhv http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y update \
&& yum install -y wget tar

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u71-b15/jdk-8u71-linux-x64.rpm" \
&& rpm -ivh jdk-8u71-linux-x64.rpm

ENV TOMCAT_TGZ_URL http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.38/bin/apache-tomcat-8.0.38.tar.gz

RUN wget "$TOMCAT_TGZ_URL" -O tomcat.tar.gz \
&& tar -xvf tomcat.tar.gz \
&& rm tomcat.tar.gz*

RUN ln -s apache-tomcat-8.0.38/ tomcat8

ADD tomcat8 /etc/init.d/tomcat8
RUN chmod u+x /etc/init.d/tomcat8

EXPOSE 8080
CMD /etc/init.d/tomcat8 start && /bin/bash
