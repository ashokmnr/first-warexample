FROM centos:7

MAINTAINER ashokmnr160@gmail.com

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat
RUN curl -O https://downloads.apache.org/tomcat/tomcat-8/v8.5.54/bin/apache-tomcat-8.5.54.tar.gz && \
    tar xvfz apache*.tar.gz && \
    mv apache-tomcat-8.5.54/* /opt/tomcat/. && \
    yum -y install java && \
    java -version

WORKDIR /opt/tomcat/webapps
COPY build/libs/first-warexample.war /opt/tomcat/webapps

EXPOSE 8080

CMD ["/opt/tomcat/bin/catalina.sh", "run"]