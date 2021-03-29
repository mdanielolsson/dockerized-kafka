FROM ubuntu:20.04

LABEL name=zookeeper
LABEL version=3.6.2

ARG ZOOKEEPER_VERSION=3.6.2

ENV SERVER_JVMFLAGS="-Djava.security.auth.login.config=/opt/apache-zookeeper/conf/zookeeper_jaas.conf"
# ENV ZOOKEEPER_OPTS="-Djava.security.auth.login.config=/opt/apache-zookeeper/conf/zookeeper_jaas.conf"
# ENV KAFKA_OPTS="-Djava.security.auth.login.config=/opt/apache-zookeeper/conf/zookeeper_jaas.conf"

RUN apt-get update && \
    apt-get install --yes --no-install-recommends gnupg2 software-properties-common net-tools curl gnupg2 netcat && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main' && \
    apt-get update && \
    apt-get install --yes --no-install-recommends zulu-11 && \
    curl -fsSL --retry 5 --retry-delay 2 https://ftp.acc.umu.se/mirror/apache.org/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -O && \
    tar zxvf apache-zookeeper-${ZOOKEEPER_VERSION}-bin.tar.gz -C /opt/ && \
    ln -sf /opt/apache-zookeeper-${ZOOKEEPER_VERSION}-bin /opt/apache-zookeeper && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY zoo.cfg /opt/apache-zookeeper/conf/zoo.cfg
COPY zookeeper_jaas.conf /opt/apache-zookeeper/conf/zookeeper_jaas.conf

EXPOSE 2181

ENTRYPOINT [ "/opt/apache-zookeeper/bin/zkServer.sh" ]
CMD [ "start-foreground" ]
