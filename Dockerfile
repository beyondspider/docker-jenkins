FROM beyondspider/tomcat:latest
MAINTAINER from www.beyondspider.com by admin (admin@beyondspider.com)

RUN yum -y install fontconfig unzip docker-client git && \
	yum clean all && \
	mkdir -p /usr/local/gradle && \
	mkdir -p /usr/local/maven && \
	mkdir -p /usr/local/node

#ADD https://download.beyondspider.com/docker/jenkins-2.176.1.war $CATALINA_HOME/webapps/jenkins.war
#ADD https://download.beyondspider.com/docker/apache-maven-3.6.1-bin.tar.gz /tmp/apache-maven-3.6.1-bin.tar.gz
#ADD https://download.beyondspider.com/docker/gradle-5.4.1-bin.zip /tmp/gradle-5.4.1-bin.zip
#ADD https://download.beyondspider.com/docker/node-v10.16.0-linux-x64.tar.xz /tmp/node-v10.16.0-linux-x64.tar.xz
#ADD https://download.beyondspider.com/docker/jenkins_home.tar.gz /usr/share/jenkins/jenkins_home.tar.gz
ADD http://localhost:10180/download/jenkins-2.176.1.war $CATALINA_HOME/webapps/jenkins.war
ADD http://localhost:10180/download/apache-maven-3.6.1-bin.tar.gz /tmp/apache-maven-3.6.1-bin.tar.gz
ADD http://localhost:10180/download/gradle-5.4.1-bin.zip /tmp/gradle-5.4.1-bin.zip
ADD http://localhost:10180/download/node-v10.16.0-linux-x64.tar.xz /tmp/node-v10.16.0-linux-x64.tar.xz
ADD http://localhost:10180/download/jenkins_home.tar.gz /usr/share/jenkins/jenkins_home.tar.gz

RUN tar -xzvf /tmp/apache-maven-3.6.1-bin.tar.gz -C /usr/local/maven && \
	unzip /tmp/gradle-5.4.1-bin.zip -d /usr/local/gradle && \
	xz -d /tmp/node-v10.16.0-linux-x64.tar.xz && \
	tar -xvf /tmp/node-v10.16.0-linux-x64.tar -C /usr/local/node && \
	rm -rf /tmp/apache-maven-3.6.1-bin.tar.gz && \
	rm -rf /tmp/gradle-5.4.1-bin.zip && \
	rm -rf /tmp/node-v10.16.0-linux-x64.tar

ENV GRADLE_HOME /usr/local/gradle/gradle-5.4.1
ENV PATH $GRADLE_HOME/bin:$PATH

ENV MAVEN_HOME /usr/local/maven/apache-maven-3.6.1
ENV PATH $MAVEN_HOME/bin:$PATH

ENV NODE_HOME /usr/local/node/node-v10.16.0-linux-x64
ENV PATH $NODE_HOME/bin:$PATH

ENV JENKINS_HOME /var/jenkins_home
VOLUME ["/var/jenkins_home"]


ADD run.sh /run.sh
ADD jenkins_home.sh /jenkins_home.sh

RUN chmod 777 /*.sh && \
	echo "export $(cat /proc/1/environ |tr '\0' '\n' | xargs)" >> /etc/profile

