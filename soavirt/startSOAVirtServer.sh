#!/bin/sh

# Evaluate and replace the environment variables in the Data Repository Server
if [ -f $DATA_REPOSITORY_HOME/server.sh ]
then
	sed -i "s/\$CTP_HOST/$CTP_HOST/g" $DATA_REPOSITORY_HOME/server.sh
	sed -i "s/\$CTP_PORT/$CTP_PORT/g" $DATA_REPOSITORY_HOME/server.sh
	sed -i "s/\$CTP_USERNAME/$CTP_USERNAME/g" $DATA_REPOSITORY_HOME/server.sh
	sed -i "s/\$CTP_PASSWORD/$CTP_PASSWORD/g" $DATA_REPOSITORY_HOME/server.sh
	$DATA_REPOSITORY_HOME/server.sh start
fi

# Evaluate and replace the environment variables in the Virtualize config

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

export CATALINA_BASE=$CATALINA_HOME/soavirt
$CATALINA_HOME/bin/catalina.sh run
