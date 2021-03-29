FROM ubuntu:20.04

LABEL name=kafka
LABEL version=2.7.0

ARG KAFKA_VERSION=2.7.0
ARG SCALA_VERSION=2.13
ARG OPA_KAFKA_PLUGIN_VERSION=1.0.0

ENV KAFKA_OPTS=-Djava.security.auth.login.config=/opt/kafka/config/kafka_server_jaas.conf
#ENV KAFKA_JMX_OPTS="-Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.authenticate=false  -Dcom.sun.management.jmxremote.ssl=false -Djavax.net.debug=all "

RUN mkdir -p /usr/local/share/kafka/plugins/ && \
    apt-get update && \
    apt-get install --yes --no-install-recommends gnupg2 software-properties-common net-tools curl gnupg2 netcat vim openssl && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main' && \
    apt-get update && \
    apt-get install --yes --no-install-recommends zulu-11 && \
    curl -fsSL https://ftpmirror1.infania.net/mirror/apache/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -O && \
    tar zxvf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt/ && \
    ln -sf /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} /opt/kafka && \
    curl -fsSL https://github.com/Bisnode/opa-kafka-plugin/releases/download/v${OPA_KAFKA_PLUGIN_VERSION}/opa-authorizer-${OPA_KAFKA_PLUGIN_VERSION}-all.jar \
        -o /usr/local/share/kafka/plugins/opa-authorizer-${OPA_KAFKA_PLUGIN_VERSION}-all.jar && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
COPY server.properties /opt/kafka/config/server.properties
COPY kafka_server_jaas.conf /opt/kafka/config/kafka_server_jaas.conf
COPY log4j.properties /opt/kafka/config/log4j.properties
COPY add_users.sh /add_users.sh

CMD [ "/entrypoint.sh" ]
