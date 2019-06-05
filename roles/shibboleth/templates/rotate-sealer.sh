#!/bin/sh
 
IDP_HOME=/opt/shibboleth-idp
 
java -cp "$IDP_HOME/webapp/WEB-INF/lib/*" \
  net.shibboleth.utilities.java.support.security.BasicKeystoreKeyStrategyTool \
  --storefile $IDP_HOME/credentials/sealer.jks \
  --versionfile $IDP_HOME/credentials/sealer.kver \
  --alias secret \
  --storepass "$(grep '^idp.sealer.password' $IDP_HOME/conf/credentials.properties | cut -d = -f 2)"