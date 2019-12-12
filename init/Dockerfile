FROM ubuntu:18.04

RUN apt update && \
    apt install -y gnupg2 software-properties-common net-tools curl gnupg2 netcat && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9 && \
    apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main' && \
    apt update && \
    apt install -y zulu-11 && \
    curl -sf http://apache.mirrors.spacedump.net/kafka/2.3.1/kafka_2.12-2.3.1.tgz -O && \
    tar zxvf kafka_2.12-2.3.1.tgz -C /opt/ && \
    ln -sf /opt/kafka_2.12-2.3.1 /opt/kafka

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
