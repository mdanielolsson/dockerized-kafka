#!/bin/bash

# Wait for zookeeper to be available
while [ "$(echo ruok|/bin/nc zookeeper 2181)" != "imok" ]; do
    echo "Zookeeper not yet available.."
    sleep 5
done

# ACLs
# Superusers are defined in server.properties
# Username: producer
# Allowed to produce on any topic, no "Read"
# Allowed to Describe consumer groups.
/opt/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=zookeeper:2181/kafka_1 \
    --add --allow-principal User:producer --producer --topic "*"
/opt/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=zookeeper:2181/kafka_1 \
    --add --allow-principal User:producer --operation All --group "*"

# Username: consumer
# Allowed to consume on any topic and any consumer group, no "Write"
/opt/kafka/bin/kafka-acls.sh --authorizer-properties zookeeper.connect=zookeeper:2181/kafka_1 \
    --add --allow-principal User:consumer --consumer --group "*" --topic "*"

# Start kafka
/opt/kafka/bin/kafka-server-start.sh /opt/kafka/config/server.properties
