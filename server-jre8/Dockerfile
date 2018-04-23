FROM centos:latest

ENV JRE_VERSION 8u172
ENV JRE_FOLDER jdk1.8.0_172
ENV JRE_CHECKSUM 1e4cdd3c3e8c524c02f52981b6ddfc0e
ENV JAVA_HOME /usr/java/latest

# Download and install the required version of Oracle's server JRE
RUN set -x \
	&& yum install -y wget \
	&& wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/$JRE_VERSION-b11/a58eab1ec242421181065cdc37240b08/server-jre-$JRE_VERSION-linux-x64.tar.gz" \
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