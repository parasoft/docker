FROM soavirt

ARG CTP_URL=https://www1.parasoft.com/downloads/virtualize/parasoft_continuous_testing_platform_2021.1.0.zip
ENV CTP_HOME /usr/local/parasoft/ctp
ENV PATH ${CTP_HOME}:${PATH}
WORKDIR ${CTP_HOME}

COPY . ./

ENV CATALINA_OPTS "-Xms768M -Xmx768M -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC"
ENV LICENSE_SERVER_HOST localhost
ENV LICENSE_SERVER_PORT 8080
ENV LICENSE_SERVER_AUTH_ENABLED false
ENV LICENSE_SERVER_USERNAME admin
ENV LICENSE_SERVER_PASSWORD admin

RUN set -x \
	&& curl -OfSL "${CTP_URL}" --retry 999 --retry-max-time 0 -C -\
	&& CTP_FILE=`basename ${CTP_URL}` \
	&& yum install -y unzip \
	&& unzip ${CTP_FILE} \
	&& rm ${CTP_FILE}* \
	&& mkdir -p ${CATALINA_HOME}/ctp/conf/Catalina/localhost \
	&& mkdir -p ${CATALINA_HOME}/ctp/webapps/em/ \
	&& mkdir ${CATALINA_HOME}/ctp/logs \
	&& mkdir ${CATALINA_HOME}/ctp/temp \
	&& mkdir ${CATALINA_HOME}/ctp/work \
	&& cp ${CATALINA_HOME}/conf/logging.properties ${CATALINA_HOME}/ctp/conf/ \
	&& cp ${CATALINA_HOME}/conf/server.xml ${CATALINA_HOME}/ctp/conf/ \
	&& cp ${CATALINA_HOME}/conf/tomcat-users.xml ${CATALINA_HOME}/ctp/conf/ \
	&& cp ${CATALINA_HOME}/conf/web.xml ${CATALINA_HOME}/ctp/conf/ \
	&& cp -r ${CATALINA_HOME}/webapps/* ${CATALINA_HOME}/ctp/webapps/ \
	&& mv pstsec.war ${CATALINA_HOME}/ctp/webapps/ \
	&& unzip em.war -d ${CATALINA_HOME}/ctp/webapps/em/ \
	&& mv database.properties ${CATALINA_HOME}/ctp/webapps/em/WEB-INF/classes/META-INF/spring/ \
	&& mv license ${CATALINA_HOME}/ctp/webapps/em/ \
	&& mv PSTSecConfig.xml ${CATALINA_HOME}/ctp/webapps/em/config/ \
	&& echo "<% response.sendRedirect(\"/em\"); %>" >> ${CATALINA_HOME}/ctp/webapps/ROOT/index.jsp \
	&& yum -y remove unzip \
	&& yum clean all

EXPOSE 8080 2002

CMD [ "startCTP.sh" ]
