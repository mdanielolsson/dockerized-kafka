#!/bin/bash
# Wait for zookeeper to be available
while [ "$(echo ruok|/bin/nc zookeeper 2181)" != "imok" ]; do
    echo "Zookeeper not yet available.."
    sleep 5
done
# Start kafka
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties