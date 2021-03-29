#!/usr/bin/env bash

while [ "$(echo ruok|/bin/nc zookeeper 2181)" != "imok" ]; do
    echo "Waiting for zookeeper to become available .."
    sleep 5
done
echo "Zookeeper isok!"

/opt/kafka/bin/kafka-topics.sh --create \
    --bootstrap-server kafka:9093 \
    --replication-factor 1 \
    --partitions 10 \
    --topic alice-topic

/opt/kafka/bin/kafka-topics.sh --create \
    --bootstrap-server kafka:9093 \
    --replication-factor 1 \
    --partitions 10 \
    --topic bob-topic

/opt/kafka/bin/kafka-configs.sh --bootstrap-server kafka:9093 --alter \
    --add-config 'SCRAM-SHA-256=[iterations=8192,password=alice-secret],SCRAM-SHA-512=[password=alice-secret]' \
    --entity-type users \
    --entity-name alice-consumer

/opt/kafka/bin/kafka-configs.sh --bootstrap-server kafka:9093 --alter \
    --add-config 'SCRAM-SHA-256=[iterations=8192,password=alice-secret],SCRAM-SHA-512=[password=alice-secret]' \
    --entity-type users \
    --entity-name alice-producer

/opt/kafka/bin/kafka-configs.sh --bootstrap-server kafka:9093 --alter \
    --add-config 'SCRAM-SHA-256=[iterations=8192,password=bob-secret],SCRAM-SHA-512=[password=bob-secret]' \
    --entity-type users \
    --entity-name bob-consumer

/opt/kafka/bin/kafka-configs.sh --bootstrap-server kafka:9093 --alter \
    --add-config 'SCRAM-SHA-256=[iterations=8192,password=bob-secret],SCRAM-SHA-512=[password=bob-secret]' \
    --entity-type users \
    --entity-name bob-producer
