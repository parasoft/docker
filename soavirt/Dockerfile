FROM datarepository

ENV SOAVIRT_HOME /usr/local/parasoft/soavirt
ENV PATH $SOAVIRT_HOME:$PATH
RUN mkdir -p "$SOAVIRT_HOME"
COPY parasoft_soavirt_server_9.10.3.zip $SOAVIRT_HOME
WORKDIR $SOAVIRT_HOME

ENV CATALINA_OPTS "-Xms768M -Xmx768M -server -XX:+UseConcMarkSweepGC -XX:+UseParNewGC"

ENV VIRTUALIZE_SERVER_NAME Docker
ENV CTP_HOST localhost
ENV CTP_PORT 8080
ENV CTP_USERNAME admin
ENV CTP_PASSWORD admin
ENV CTP_NOTIFY true

ENV LICENSE_EDITION custom_edition
ENV LICENSE_FEATURES "Service Enabled, Performance, Extension Pack, Validate, Message Packs, Unlimited Hits\/Day, 1 Million Hits\/Day, 500000 Hits\/Day, 100000 Hits\/Day, 50000 Hits\/Day, 25000 Hits\/Day, 10000 Hits\/Day"
ENV LICENSE_SERVER_HOST localhost
ENV LICENSE_SERVER_PORT 2002

RUN set -x \
	&& yum install -y unzip \
	&& unzip parasoft_soavirt_server_9.10.3.zip \
	&& rm parasoft_soavirt_server_9.10.3.zip \
	&& yum clean all \
	&& yum -y remove unzip \
	&& $JAVA_HOME/bin/jar -xf soavirt.war \
	&& rm soavirt.war \
	&& mkdir -p $CATALINA_HOME/soavirt \
	&& mkdir -p $CATALINA_HOME/soavirt/conf/Catalina/localhost \
	&& mkdir $CATALINA_HOME/soavirt/logs \
	&& mkdir $CATALINA_HOME/soavirt/temp \
	&& mkdir $CATALINA_HOME/soavirt/webapps \
	&& mkdir $CATALINA_HOME/soavirt/work \
	&& cp $CATALINA_HOME/conf/logging.properties $CATALINA_HOME/soavirt/conf/ \
	&& cp $CATALINA_HOME/conf/server.xml $CATALINA_HOME/soavirt/conf/ \
	&& cp $CATALINA_HOME/conf/web.xml $CATALINA_HOME/soavirt/conf/ \
	&& cp -r $CATALINA_HOME/webapps/* $CATALINA_HOME/soavirt/webapps/ \
	&& echo "<Context docBase=\"$SOAVIRT_HOME\" path=\"\" reloadable=\"true\" />" > $CATALINA_HOME/soavirt/conf/Catalina/localhost/ROOT.xml \
	&& sed -i 's/8080/9080/g' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/8443/9443/g' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/8080/9080/g' $CATALINA_HOME/soavirt/conf/server.xml \
	&& sed -i 's/8005/9005/g' $CATALINA_HOME/soavirt/conf/server.xml \
	&& sed -i 's/8443/9443/g' $CATALINA_HOME/soavirt/conf/server.xml \
	&& sed -i 's/8009/0/g' $CATALINA_HOME/soavirt/conf/server.xml

RUN set -x \
	&& sed -i 's/^#env.manager.server.name=.*/env.manager.server.name=$VIRTUALIZE_SERVER_NAME/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.server=.*/env.manager.server=http:\/\/$CTP_HOST:$CTP_PORT/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.username=.*/env.manager.username=$CTP_USERNAME/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.password=.*/env.manager.password=$CTP_PASSWORD/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#env.manager.notify=.*/env.manager.notify=$CTP_NOTIFY/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#virtualize.license.use_network=.*/virtualize.license.use_network=true/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#virtualize.license.network.edition=.*/virtualize.license.network.edition=$LICENSE_EDITION/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#virtualize.license.custom_edition_features=.*/virtualize.license.custom_edition_features=$LICENSE_FEATURES/' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.host=.*//' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& sed -i 's/^#license.network.port=.*//' $SOAVIRT_HOME/WEB-INF/config.properties \
	&& echo 'license.network.host=$LICENSE_SERVER_HOST' >> $SOAVIRT_HOME/WEB-INF/config.properties \
	&& echo 'license.network.port=$LICENSE_SERVER_PORT' >> $SOAVIRT_HOME/WEB-INF/config.properties

COPY startSOAVirtServer.sh .

RUN chmod +x startSOAVirtServer.sh

EXPOSE 9080 9443

CMD ["startSOAVirtServer.sh"]