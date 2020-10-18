FROM daggerok/jboss-eap-7.3:7.3.0-debian                                                     

USER root                                                                                             
# debug:                                                                                     
ENV JAVA_OPTS="$JAVA_OPTS -Xms1024m -Xmx1024m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=1024m"                                                                             
  
COPY docker-entrypoint.sh $JBOSS_HOME/docker-entrypoint.sh
RUN chown jboss $JBOSS_HOME/docker-entrypoint.sh && \
 	chmod a+x $JBOSS_HOME/docker-entrypoint.sh

RUN mkdir -p /usr/local/.m2/repository

ADD configuration/settings.xml /usr/local/.m2/

ADD configuration/settings.xml $JBOSS_HOME/standalone/configuration/
ADD configuration/application-users.properties $JBOSS_HOME/standalone/configuration/
ADD configuration/application-roles.properties $JBOSS_HOME/standalone/configuration/
ADD configuration/system.propertie $JBOSS_HOME/bin/		
ADD application/business-central.war $JBOSS_HOME/standalone/deployments/
ADD application/business-central.war.deployed $JBOSS_HOME/standalone/deployments/


EXPOSE 8181/tcp 9990 7600 8888  
ENTRYPOINT $JBOSS_HOME/docker-entrypoint.sh