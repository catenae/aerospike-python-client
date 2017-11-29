#!/bin/bash

docker build -t catenae/aerospike-client-python:2.2.3 .
docker build -t catenae/aerospike-client-python .

docker push catenae/aerospike-client-python:2.2.3
docker push catenae/aerospike-client-python
