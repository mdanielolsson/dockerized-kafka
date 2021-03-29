# Dockerized Kafka & Zookeeper

Using docker-compose this sets up a Kafka broker with an OPA container and Zookeeper.

It creates 3 main users for Plain auth.

|Username|Password|Permissions|
|---|---|---|
|consumer| consumer-secret|Describe, Write, Create|
|producer| producer-secret|Describe, Read, Create|
|superman| superman-secret|*|

Authorization for Kafka is handled by OPA through the opa-authorizer plugin.
The policy used can be found in ./opa/policies/policy.rego

# Build from source

These containers aren't pushed to any registry, so they need to be built locally.

Clone this repository and run `docker-compose up --build`

# Connect
The Kafka container exposes port 9093 for completely unauthenticated connections (ANONYMOUS). This is also the inter-broker port.
For authenticated connections it listens on 9092 for SCRAM-SHA-256, or PLAIN auth mechanisms using SASL_PLAINTEXT.

Zookeeper can be reached from within the Kafka container on zookeeper:2181
The connection to zookeeper is authenticated.

## Kafkacat examples
### Consume as consumer on `test` topic
`kafkacat -b localhost:9092 -X "security.protocol=SASL_PLAINTEXT" -X "sasl.mechanisms=PLAIN" -X "sasl.username=consumer" -X "sasl.password=consumer-secret" -C -t test`

### Produce as producer on `test` topic
`echo Hello |kafkacat -b localhost:9092 -X "security.protocol=SASL_PLAINTEXT" -X "sasl.mechanisms=PLAIN" -X "sasl.username=producer" -X "sasl.password=producer-secret" -P -t test`

### List
`kafkacat -b localhost:9092 -X "security.protocol=SASL_PLAINTEXT" -X "sasl.mechanisms=PLAIN" -X "sasl.username=producer" -X "sasl.password=producer-secret" -L`

# Logging

By default debug logging is enabled on authentication module.

# Todo:

- Create a more realistic policy
- Add policy tests
- Maybe change to more light weight containers
- Add option to have more brokers?
