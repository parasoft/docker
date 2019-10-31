#!/bin/sh

# Evaluate and replace the environment variables in the Virtualize config
if [ -f $SOAVIRT_HOME/WEB-INF/config.properties ]
then
	sed -i "s/\$VIRTUALIZE_SERVER_NAME/$VIRTUALIZE_SERVER_NAME/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$VIRTUALIZE_SERVER_PORT/$VIRTUALIZE_SERVER_PORT/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$VIRTUALIZE_SERVER_SECURE_PORT/$VIRTUALIZE_SERVER_SECURE_PORT/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$CTP_HOST/$CTP_HOST/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$CTP_PORT/$CTP_PORT/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$CTP_USERNAME/$CTP_USERNAME/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$CTP_PASSWORD/$CTP_PASSWORD/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$CTP_NOTIFY/$CTP_NOTIFY/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_EDITION/$LICENSE_EDITION/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_FEATURES/$LICENSE_FEATURES/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$SOATEST_LICENSE_FEATURES/$SOATEST_LICENSE_FEATURES/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_SERVER_HOST/$LICENSE_SERVER_HOST/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_SERVER_PORT/$LICENSE_SERVER_PORT/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_SERVER_AUTH_ENABLED/$LICENSE_SERVER_AUTH_ENABLED/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_SERVER_USERNAME/$LICENSE_SERVER_USERNAME/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_SERVER_PASSWORD/$LICENSE_SERVER_PASSWORD/g" $SOAVIRT_HOME/WEB-INF/config.properties
	sed -i "s/\$LICENSE_SERVER_HOST/$LICENSE_SERVER_HOST/g" $CATALINA_HOME/ctp/webapps/em/license
	sed -i "s/\$LICENSE_SERVER_PORT/$LICENSE_SERVER_PORT/g" $CATALINA_HOME/ctp/webapps/em/license
	sed -i "s/\$LICENSE_SERVER_AUTH_ENABLED/$LICENSE_SERVER_AUTH_ENABLED/g" $CATALINA_HOME/ctp/webapps/em/license
	sed -i "s/\$LICENSE_SERVER_USERNAME/$LICENSE_SERVER_USERNAME/g" $CATALINA_HOME/ctp/webapps/em/license
	sed -i "s/\$LICENSE_SERVER_PASSWORD/$LICENSE_SERVER_PASSWORD/g" $CATALINA_HOME/ctp/webapps/em/license
fi

echo "Starting the Continuous Testing Platform..."
mkdir -p $SOAVIRT_HOME/workspace/VirtualAssets/logs/ctp
export CATALINA_BASE=$CATALINA_HOME/ctp
nohup $CATALINA_HOME/bin/catalina.sh run >> $SOAVIRT_HOME/workspace/VirtualAssets/logs/ctp/catalina.log 2>&1 &
sleep 5
tail $SOAVIRT_HOME/workspace/VirtualAssets/logs/ctp/catalina.log
sleep 25 # Wait for CTP to start up so TDM and Virtualize can register
tail $SOAVIRT_HOME/workspace/VirtualAssets/logs/ctp/catalina.log

# Evaluate and replace the environment variables in the Data Repository Server
if [ -f $DATA_REPOSITORY_HOME/server.sh ]
then
	sed -i "s/\$CTP_HOST/$CTP_HOST/g" $DATA_REPOSITORY_HOME/server.sh
	sed -i "s/\$CTP_PORT/$CTP_PORT/g" $DATA_REPOSITORY_HOME/server.sh
	sed -i "s/\$CTP_USERNAME/$CTP_USERNAME/g" $DATA_REPOSITORY_HOME/server.sh
	sed -i "s/\$CTP_PASSWORD/$CTP_PASSWORD/g" $DATA_REPOSITORY_HOME/server.sh
	$DATA_REPOSITORY_HOME/server.sh start
fi

if [ -f $SOAVIRT_HOME/WEB-INF/config.properties ]
then
	echo "Starting the SOAVirt server..."
	mkdir -p $SOAVIRT_HOME/workspace/VirtualAssets/logs/virtualize
	export CATALINA_BASE=$CATALINA_HOME/soavirt
	nohup $CATALINA_HOME/bin/catalina.sh run >> $SOAVIRT_HOME/workspace/VirtualAssets/logs/virtualize/catalina.log 2>&1 &
	sleep 5
	# Wait for the user to press Ctrl-C to initiate shutdown
	tail -f $SOAVIRT_HOME/workspace/VirtualAssets/logs/virtualize/catalina.log
	export CATALINA_BASE=$CATALINA_HOME/soavirt
	$CATALINA_HOME/bin/catalina.sh stop
	sleep 5
	tail $SOAVIRT_HOME/workspace/VirtualAssets/logs/virtualize/catalina.log
else
	# Wait for the user to press Ctrl-C to initiate shutdown
	tail -f $SOAVIRT_HOME/workspace/VirtualAssets/logs/ctp/catalina.log
fi

export CATALINA_BASE=$CATALINA_HOME/ctp
$CATALINA_HOME/bin/catalina.sh stop
sleep 5
tail $SOAVIRT_HOME/workspace/VirtualAssets/logs/ctp/catalina.log
