#!/bin/sh

IDP_HOME=/opt/shibboleth-idp
export JAVA_HOME=/usr/lib/jvm/jre

$IDP_HOME/bin/seckeygen.sh \
    --storefile $IDP_HOME/credentials/sealer.jks \
    --storepass "$(grep '^idp.sealer.password' $IDP_HOME/conf/credentials.properties | cut -d = -f 3 | awk '{print $1}')" \
    --versionfile $IDP_HOME/credentials/sealer.kver \
    --alias secret