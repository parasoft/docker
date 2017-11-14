FROM centos:latest

ENV JRE_VERSION 8u152
ENV JRE_FOLDER jdk1.8.0_152
ENV JRE_CHECKSUM 004a1020ebf48f5e4e0cac79d68e9670
ENV JAVA_HOME /usr/java/latest

# Download and install the required version of Oracle's server JRE
RUN set -x \
	&& yum install -y wget \
	&& wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JRE_VERSION-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/server-jre-$JRE_VERSION-linux-x64.tar.gz" \
	&& echo "$JRE_CHECKSUM  server-jre-$JRE_VERSION-linux-x64.tar.gz" >> MD5SUM \
	&& md5sum -c MD5SUM \
	&& mkdir -p /usr/java \
	&& tar -xzf "server-jre-$JRE_VERSION-linux-x64.tar.gz" -C /usr/java \
	&& yum clean all \
	&& yum -y remove wget \
	&& rm -rf "server-jre-$JRE_VERSION-linux-x64.tar.gz" \
	    MD5SUM \
	&& ln -s /usr/java/$JRE_FOLDER $JAVA_HOME \
	&& update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 999999

# If running this image directly, we most likely want bash
CMD ["/bin/bash", "--login"]