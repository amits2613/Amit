#The base image to use in build 
FROM centos:centos6
MAINTAINER Amit Sharma <amits2613@gmail.com>
 
# updation and installation of extra required package
RUN yum install -y update;
RUN yum install -y epel-release;

# Installation of MongoDB

#Adding MongoDB key and Creating repository for MongoDB
RUN echo -e "[mongodb]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/redhat/6/mongodb-org/3.2/`uname -m`/\ngpgcheck=0\nenable=1" > /etc/yum.repos.d/mongodb.repo

# Installing MongoDB package
RUN yum install -y mongodb-org;

# Creating MongoDB data directory	
RUN mkdir -p /data/db 			

EXPOSE	27017				#Expose port 27017 from the container to the host
ENTRYPOINT ["/usr/bin/mongodb"]		#It will tell the Docker to run mongodb inside the container


#Installation of Python 2.7
RUN yum install -y python27

#Installation of Tomcat 7

#Download Java jdk 

RUN cd /tmp;wget http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz

RUN cd /tmp; tar xvf jdk-8u131-linux-x64.tar.gz
RUN alternatives --install /usr/bin/java java /tmp/jdk-8u131/bin/java 2
 
#Download Apache tomcat 7
RUN cd /tmp;wget http://mirror.fibergrid.in/apache/tomcat/tomcat-7/v7.0.77/bin/apache-tomcat-7.0.77.tar.gz  

# Untar Tomcat 7 and move to a location
RUN cd /tmp;tar xvf apache-tomcat-7.0.77.tar.gz
RUN cd /tmp;mv apache-tomcat-7.0.77 /opt/tomcat7
RUN chmod -R 755 /opt/tomcat7

#Sets an environment variable in the new container
ENV JAVA_HOME /tmp/jdk-8u131

#Open an port for linked container
EXPOSE 7080
 
#The command that runs when container starts
CMD ["catalina.sh" "run"]
