#!/usr/bin/env bash

while [ "$(echo ruok|/bin/nc zookeeper 2181)" != "imok" ]; do
    echo "Waiting for zookeeper to become available .."
    sleep 5
done
echo "Zookeeper isok!"

# Start kafka
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
