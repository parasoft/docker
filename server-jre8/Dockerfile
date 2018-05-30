FROM centos:latest

ARG JRE_VERSION=8u172
ARG JRE_FOLDER=jdk1.8.0_172
ARG JRE_URL=http://download.oracle.com/otn-pub/java/jdk/${JRE_VERSION}-b11/a58eab1ec242421181065cdc37240b08/server-jre-${JRE_VERSION}-linux-x64.tar.gz
ARG JRE_CHECKSUM=1e4cdd3c3e8c524c02f52981b6ddfc0e
ENV JAVA_HOME /usr/java/latest
WORKDIR /usr/java

# Download and install the required version of Oracle's server JRE
RUN set -x \
	&& curl -jOfSL "${JRE_URL}" --header "Cookie: oraclelicense=accept-securebackup-cookie" --retry 999 --retry-max-time 0 -C -\
	&& JRE_FILE=`basename ${JRE_URL}` \
	&& echo "${JRE_CHECKSUM}  ${JRE_FILE}" > ${JRE_FILE}.md5 \
	&& md5sum -c ${JRE_FILE}.md5 \
	&& tar -xzf ${JRE_FILE} -C /usr/java \
	&& rm -rf ${JRE_FILE}* \
	&& ln -s ${JRE_FOLDER} ${JAVA_HOME} \
	&& update-alternatives --install /usr/bin/java java ${JAVA_HOME}/bin/java 999999

# If running this image directly, we most likely want bash
CMD [ "/bin/bash", "--login" ]