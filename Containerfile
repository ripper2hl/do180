FROM quay.io/centos/centos
RUN mkdir -p /opt/rh
WORKDIR /opt/rh
COPY w.zip .
RUN ls -lha
RUN dnf --disablerepo '*' -y --enablerepo=extras swap centos-linux-repos centos-stream-repos
RUN dnf -y install unzip java-1.8.0-openjdk-devel
RUN unzip w.zip
RUN ls -lha
RUN useradd user
RUN chown -R user:user .
RUN chmod 775 .
ENV JBOSS_HOME /opt/rh/wildfly-26.1.1.Final
RUN $JBOSS_HOME/bin/add-user.sh admin admin@2016 --silent
ENTRYPOINT $JBOSS_HOME/bin/standalone.sh -c standalone-full-ha.xml
