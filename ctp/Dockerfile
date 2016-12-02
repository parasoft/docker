FROM soavirt

ENV CTP_HOME /usr/local/parasoft/ctp
ENV PATH $CTP_HOME:$PATH
RUN mkdir -p "$CTP_HOME"
COPY parasoft_continuous_testing_platform_3.0.zip $CTP_HOME
COPY database.properties $CTP_HOME
COPY license $CTP_HOME
COPY PSTSecConfig.xml $CTP_HOME
WORKDIR $CTP_HOME

ENV CATALINA_OPTS "-Xmx2g -Xms2g"

RUN set -x \
	&& yum install -y unzip \
	&& unzip parasoft_continuous_testing_platform_3.0.zip \
	&& rm parasoft_continuous_testing_platform_3.0.zip \
	&& mkdir -p $CATALINA_HOME/ctp \
	&& mkdir -p $CATALINA_HOME/ctp/conf/Catalina/localhost \
	&& mkdir $CATALINA_HOME/ctp/logs \
	&& mkdir $CATALINA_HOME/ctp/temp \
	&& mkdir $CATALINA_HOME/ctp/webapps \
	&& mkdir $CATALINA_HOME/ctp/work \
	&& cp $CATALINA_HOME/conf/logging.properties $CATALINA_HOME/ctp/conf/ \
	&& cp $CATALINA_HOME/conf/server.xml $CATALINA_HOME/ctp/conf/ \
	&& cp $CATALINA_HOME/conf/web.xml $CATALINA_HOME/ctp/conf/ \
	&& cp -r $CATALINA_HOME/webapps/* $CATALINA_HOME/ctp/webapps/ \
	&& mv licenseserver.war $CATALINA_HOME/ctp/webapps/ \
	&& mv pstsec.war $CATALINA_HOME/ctp/webapps/ \
	&& mkdir $CATALINA_HOME/ctp/webapps/em/ \
	&& unzip em.war -d $CATALINA_HOME/ctp/webapps/em/ \
	&& mv database.properties $CATALINA_HOME/ctp/webapps/em/WEB-INF/classes/META-INF/spring/ \
	&& mv license $CATALINA_HOME/ctp/webapps/em/ \
	&& mv PSTSecConfig.xml $CATALINA_HOME/ctp/webapps/em/config/ \
	&& echo "<% response.sendRedirect(\"/em\"); %>" >> $CATALINA_HOME/ctp/webapps/ROOT/index.jsp \
	&& yum clean all \
	&& yum -y remove unzip

COPY startCTP.sh .

RUN chmod +x startCTP.sh

EXPOSE 8080 2002

CMD ["startCTP.sh"]