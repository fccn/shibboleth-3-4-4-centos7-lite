#!/bin/bash -e
#
# 20170124 - Changed by RCTSaai - Java8 and tomcat user
#
# idp-install.sh - custom installer for the Shibboleth IdP 3
#
# Copyright (c) 2015 SWITCH
PSQLPW=$(openssl rand -base64 12)
echo "psql.password = $PSQLPW" >>/opt/shibboleth-idp/conf/credentials.properties
echo "ALTER USER shibboleth WITH PASSWORD '$PSQLPW';" | su - postgres -c psql >/dev/null