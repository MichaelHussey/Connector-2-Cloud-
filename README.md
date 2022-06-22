# Simple setup with 3 connector types installed and running C3 to help with connector configs #

This set-up is a simplified version of the connect-distributed setup in the [examples](https://github.com/confluentinc/cp-all-in-one/tree/7.1.0-post/Docker-connect/distributed) 

## Build the docker image ##

First download the connector zip files and place in the `./connectors` directory. Either use the browser to download the latest zip files for [MSSQL CDC](https://www.confluent.io/hub/debezium/debezium-connector-sqlserver), [Rabbit MQ](https://www.confluent.io/hub/confluentinc/kafka-connect-rabbitmq) and [JDBC](https://www.confluent.io/hub/confluentinc/kafka-connect-jdbc) or use `wget` to access these specific versions.

````
wget https://d1i4a15mxbxib1.cloudfront.net/api/plugins/debezium/debezium-connector-sqlserver/versions/1.9.2/debezium-debezium-connector-sqlserver-1.9.2.zip
wget https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-rabbitmq/versions/1.7.3/confluentinc-kafka-connect-rabbitmq-1.7.3.zip
wget https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-jdbc/versions/10.5.0/confluentinc-kafka-connect-jdbc-10.5.0.zip 
mv *.zip connectors
`````

Now build the image
````
docker build -t localbuild/connect:1.0 .
````

## Set up API keys for SR and Kafka ##

Copy `cloud.env.template` to `cloud.env` and place your API keys in it.

Start connect and C3.
````
docker-compose --env-file cloud.env --file ./docker-compose_wc3.yml up
````

Check that the connectors have been registered by loading `http://localhost:8083/connector-plugins`

Check that everything has come up cleanly and access C3 at port 9021.


