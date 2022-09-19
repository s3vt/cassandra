ARG OPENJRE_VERSION
FROM sapvs/openjre-alpine:${OPENJRE_VERSION}

LABEL repo="https://github.com/sapvs/cassandra-alpine"

ARG CASSANDRA_VERSION
RUN mkdir /opt/cassandra
WORKDIR /opt/cassandra
ENV CASSANDRA_HOME=/opt/cassandra

ADD https://downloads.apache.org/cassandra/${CASSANDRA_VERSION}/apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz .

COPY start_cassandra.sh .

RUN addgroup -S cassandra && adduser -S cassandra -G cassandra

RUN tar -xzf apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz -C /opt/cassandra --strip-components=1 \
  && rm apache-cassandra-${CASSANDRA_VERSION}-bin.tar.gz \
  && chown -R cassandra:cassandra /opt/cassandra \
  && chmod a+x start_cassandra.sh

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160
USER cassandra

ENTRYPOINT [ "./start_cassandra.sh"]

CMD [ "cassandra", "-f"]
