#!/usr/bin/env bash

while [ "$(/bin/nc zookeeper 2181 <<< ruok)" != "imok" ]; do
    echo "Waiting for zookeeper to become available .."
    sleep 5
done
echo "Zookeeper isok!"

/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
