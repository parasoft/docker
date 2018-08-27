FROM centos:latest

ARG JRE_VERSION=8u181
ARG JRE_FOLDER=jdk1.8.0_181
ARG JRE_URL=http://download.oracle.com/otn-pub/java/jdk/${JRE_VERSION}-b13/96a7b8442fe848ef90c96a2fad6ed6d1/server-jre-${JRE_VERSION}-linux-x64.tar.gz
ARG JRE_CHECKSUM=5c8092c606ef28c2e3ad850354a2c53a
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