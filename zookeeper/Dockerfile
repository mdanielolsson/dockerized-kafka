FROM ubuntu:18.04

RUN apt update && \
    apt install -y --no-install-recommends \
        openjdk-8-jre-headless curl net-tools && \
    curl -fsSL --retry 5 --retry-delay 2 http://apache.mirrors.spacedump.net/zookeeper/zookeeper-3.4.14/zookeeper-3.4.14.tar.gz -O && \
    tar zxvf zookeeper-3.4.14.tar.gz -C /opt/ && \
    ln -sf /opt/zookeeper-3.4.14 /opt/zookeeper

ADD entrypoint.sh /entrypoint.sh
ADD zoo.cfg /opt/zookeeper/conf/zoo.cfg

EXPOSE 2181

ENTRYPOINT [ "/entrypoint.sh" ]