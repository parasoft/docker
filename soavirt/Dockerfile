FROM datarepository

ARG SOAVIRT_URL=https://www1.parasoft.com/downloads/virtualize/parasoft_soavirt_server_9.10.8.zip
ENV SOAVIRT_HOME /usr/local/parasoft/soavirt
ENV PATH ${SOAVIRT_HOME}:${PATH}
WORKDIR ${SOAVIRT_HOME}

ENV CATALINA_OPTS "-Xms768M -Xmx768M -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC"

ENV VIRTUALIZE_SERVER_NAME Docker
ENV VIRTUALIZE_SERVER_PORT 9080
ENV VIRTUALIZE_SERVER_SECURE_PORT 9443
ENV CTP_HOST localhost
ENV CTP_PORT 8080
ENV CTP_USERNAME admin
ENV CTP_PASSWORD admin
ENV CTP_NOTIFY true

ENV LICENSE_EDITION custom_edition
ENV LICENSE_FEATURES "Service Enabled, Performance, Extension Pack, Validate, Message Packs, Unlimited Hits\/Day, 1 Million Hits\/Day, 500000 Hits\/Day, 100000 Hits\/Day, 50000 Hits\/Day, 25000 Hits\/Day, 10000 Hits\/Day"
ENV SOATEST_LICENSE_FEATURES "RuleWizard, Command Line, SOA, Web, Server API Enabled, Jtest Connect, Stub Desktop, Stub Server, Message Packs, Advanced Test Generation 100 Users, Advanced Test Generation 25 Users, Advanced Test Generation 5 Users, Advanced Test Generation Desktop"
ENV LICENSE_SERVER_HOST localhost
ENV LICENSE_SERVER_PORT 8080
ENV LICENSE_SERVER_AUTH_ENABLED false
ENV LICENSE_SERVER_USERNAME admin
ENV LICENSE_SERVER_PASSWORD admin

COPY startSOAVirtServer.sh .

RUN set -x \
	&& curl -OfSL "${SOAVIRT_URL}" --retry 999 --retry-max-time 0 -C -\
	&& curl -OfSL "${SOAVIRT_URL}.md5" \
	&& SOAVIRT_FILE=`basename ${SOAVIRT_URL}` \
	&& md5sum -c ${SOAVIRT_FILE}.md5 \
	&& yum install -y unzip \
	&& unzip ${SOAVIRT_FILE} \
	&& unzip soavirt.war \
	&& rm ${SOAVIRT_FILE}* \
			soavirt.war \
	&& mkdir -p ${CATALINA_HOME}/soavirt/conf/Catalina/localhost \
	&& mkdir ${CATALINA_HOME}/soavirt/logs \
	&& mkdir ${CATALINA_HOME}/soavirt/temp \
	&& mkdir ${CATALINA_HOME}/soavirt/webapps \
	&& mkdir ${CATALINA_HOME}/soavirt/work \
	&& cp ${CATALINA_HOME}/conf/logging.properties ${CATALINA_HOME}/soavirt/conf/ \
	&& cp ${CATALINA_HOME}/conf/server.xml ${CATALINA_HOME}/soavirt/conf/ \
	&& cp ${CATALINA_HOME}/conf/tomcat-users.xml ${CATALINA_HOME}/soavirt/conf/ \
	&& cp ${CATALINA_HOME}/conf/web.xml ${CATALINA_HOME}/soavirt/conf/ \
	&& cp -r ${CATALINA_HOME}/webapps/* ${CATALINA_HOME}/soavirt/webapps/ \
	&& echo "<Context docBase=\"${SOAVIRT_HOME}\" path=\"\" reloadable=\"true\" />" > ${CATALINA_HOME}/soavirt/conf/Catalina/localhost/ROOT.xml \
	&& sed -i 's/8080/$VIRTUALIZE_SERVER_PORT/g' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/8443/$VIRTUALIZE_SERVER_SECURE_PORT/g' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/8005/9005/g' ${CATALINA_HOME}/soavirt/conf/server.xml \
	&& sed -i "s/8080/${VIRTUALIZE_SERVER_PORT}/g" ${CATALINA_HOME}/soavirt/conf/server.xml \
	&& sed -i "s/8443/${VIRTUALIZE_SERVER_SECURE_PORT}/g" ${CATALINA_HOME}/soavirt/conf/server.xml \
	&& sed -i 's/8009/0/g' ${CATALINA_HOME}/soavirt/conf/server.xml

RUN set -x \
	&& sed -i 's/^#env.manager.server.name=.*/env.manager.server.name=$VIRTUALIZE_SERVER_NAME/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.server=.*/env.manager.server=http:\/\/$CTP_HOST:$CTP_PORT/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.username=.*/env.manager.username=$CTP_USERNAME/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.password=.*/env.manager.password=$CTP_PASSWORD/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.notify=.*/env.manager.notify=$CTP_NOTIFY/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#soatest.license.use_network=.*/soatest.license.use_network=true/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#soatest.license.network.edition=.*/soatest.license.network.edition=$LICENSE_EDITION/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#soatest.license.custom_edition_features=.*/soatest.license.custom_edition_features=$SOATEST_LICENSE_FEATURES/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#virtualize.license.use_network=.*/virtualize.license.use_network=true/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#virtualize.license.network.edition=.*/virtualize.license.network.edition=$LICENSE_EDITION/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#virtualize.license.custom_edition_features=.*/virtualize.license.custom_edition_features=$LICENSE_FEATURES/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.use.specified.server=.*/license.network.use.specified.server=true/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.host=.*/license.network.host=$LICENSE_SERVER_HOST/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.port=.*/license.network.port=$LICENSE_SERVER_PORT/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.auth.enabled=.*/license.network.auth.enabled=$LICENSE_SERVER_AUTH_ENABLED/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.user=.*/license.network.user=$LICENSE_SERVER_USERNAME/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.password=.*/license.network.password=$LICENSE_SERVER_PASSWORD/' ${SOAVIRT_HOME}/WEB-INF/config.properties \
	&& yum -y remove unzip \
	&& yum clean all

EXPOSE ${VIRTUALIZE_SERVER_PORT} ${VIRTUALIZE_SERVER_SECURE_PORT}

CMD [ "startSOAVirtServer.sh" ]