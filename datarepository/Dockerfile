FROM tomcat8

ARG DATA_REPOSITORY_URL=https://www1.parasoft.com/downloads/virtualize/parasoft_data_repository_server_3.0_linux_x86_64.zip
ENV DATA_REPOSITORY_HOME /usr/local/parasoft/DataRepositoryServer-linux-x86_64
ENV PATH ${DATA_REPOSITORY_HOME}/bin:${PATH}
WORKDIR ${DATA_REPOSITORY_HOME}

RUN set -x \
	&& cd .. \
	&& curl -OfSL "${DATA_REPOSITORY_URL}" --retry 999 --retry-max-time 0 -C -\
	&& curl -OfSL "${DATA_REPOSITORY_URL}.md5" \
	&& DATA_REPOSITORY_FILE=`basename ${DATA_REPOSITORY_URL}` \
	&& md5sum -c ${DATA_REPOSITORY_FILE}.md5 \
	&& yum install -y unzip \
	&& unzip ${DATA_REPOSITORY_FILE} \
	&& rm ${DATA_REPOSITORY_FILE}* \
	&& sed -i 's/^TDM=.*/TDM=http:\/\/$CTP_HOST:$CTP_PORT/' $DATA_REPOSITORY_HOME/server.sh \
	&& sed -i 's/^T_USER=.*/T_USER=$CTP_USERNAME/' $DATA_REPOSITORY_HOME/server.sh \
	&& sed -i 's/^T_PASS=.*/T_PASS=$CTP_PASSWORD/' $DATA_REPOSITORY_HOME/server.sh \
	&& yum -y remove unzip \
	&& yum clean all

EXPOSE 2424

CMD ["server.sh", "start"]