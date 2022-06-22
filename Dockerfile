# Kafka Connect docker container with JDBC, CDC and RabbitMQ connector installed
FROM confluentinc/cp-server-connect-base:latest-ubi8

ENV CONNECT_PLUGIN_PATH: "/usr/share/java,/usr/share/confluent-hub-components"
COPY ./connectors/confluentinc-kafka-connect-jdbc-10.5.0.zip /tmp/confluentinc-kafka-connect-jdbc-10.5.0.zip
RUN confluent-hub install --no-prompt /tmp/confluentinc-kafka-connect-jdbc-10.5.0.zip
RUN curl -k -SL "https://download.microsoft.com/download/6/9/9/699205CA-F1F1-4DE9-9335-18546C5C8CBD/sqljdbc_7.4.1.0_enu.tar.gz"\
| tar -xzf - -C /usr/share/confluent-hub-components/confluentinc-kafka-connect-jdbc/lib \
     --strip-components=1 sqljdbc_7.4/enu/mssql-jdbc-7.4.1.jre11.jar

# Install RabbitMQ connector
# RUN confluent-hub install --no-prompt confluentinc/kafka-connect-rabbitmq-source:1.7.3
COPY ./connectors/confluentinc-kafka-connect-rabbitmq-1.7.3.zip /tmp/confluentinc-kafka-connect-rabbitmq-1.7.3.zip
RUN confluent-hub install --no-prompt /tmp/confluentinc-kafka-connect-rabbitmq-1.7.3.zip

# Install CDC for MSSQL connector
COPY ./connectors/debezium-debezium-connector-sqlserver-1.9.2.zip /tmp/debezium-debezium-connector-sqlserver-1.9.2.zip
RUN confluent-hub install --no-prompt /tmp/debezium-debezium-connector-sqlserver-1.9.2.zip