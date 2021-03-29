FROM ubuntu:20.04

LABEL name=opa
LABEL version=0.27.0

ARG OPA_VERSION='0.27.0'

RUN apt-get update && \
    apt-get install --yes --no-install-recommends curl ca-certificates && \
    curl -fsSL --retry 5 --retry-delay 2 "https://github.com/open-policy-agent/opa/releases/download/v${OPA_VERSION}/opa_linux_amd64" -o /usr/local/bin/opa && \
    chmod a+x /usr/local/bin/opa && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY policies/ /policies/
COPY opa.yaml /config/opa.yaml

EXPOSE 8181

ENTRYPOINT [ "opa" ]
CMD [ "run", "--config-file=/config/opa.yaml", "--log-level=debug", "--log-format=json-pretty", "--server", "/policies/" ]
