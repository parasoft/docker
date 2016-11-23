FROM tomcat8

ENV DATA_REPOSITORY_HOME /usr/local/parasoft/DataRepositoryServer-linux-x86_64
ENV PATH $DATA_REPOSITORY_HOME/bin:$PATH
RUN mkdir -p /usr/local/parasoft
COPY DataRepositoryServer.zip /usr/local/parasoft
WORKDIR /usr/local/parasoft

RUN set -x \
	&& yum install -y unzip \
	&& unzip DataRepositoryServer.zip \
	&& rm DataRepositoryServer.zip \
	&& yum clean all \
	&& yum -y remove unzip \
	&& sed -i 's/^TDM=.*/TDM=http:\/\/$CTP_HOST:$CTP_PORT/' $DATA_REPOSITORY_HOME/server.sh \
	&& sed -i 's/^T_USER=.*/T_USER=$CTP_USERNAME/' $DATA_REPOSITORY_HOME/server.sh \
	&& sed -i 's/^T_PASS=.*/T_PASS=$CTP_PASSWORD/' $DATA_REPOSITORY_HOME/server.sh

EXPOSE 2424

CMD ["server.sh", "start"]