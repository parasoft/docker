FROM centos:latest

# Download and install the required version of OpenJDK
RUN set -x \
	&& yum clean all \
	&& yum install -y java-1.8.0-openjdk

# If running this image directly, we most likely want bash
CMD [ "/bin/bash", "--login" ]