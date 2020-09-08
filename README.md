# Installing rabbitmq cluster
This way requires many manual steps to set up systems, but can easily add new nodes while cluster is running.

## Pre-conditions
All node has joined into docker swarm.
You can run rabbit in swarm mode or not. But we need swarm to control network

## Build image
docker build -t rabbitmq-cluster:latest -f Dockerfile .

## Create overlay network
docker network create -d overlay --attachable rabbitmq-network

## Create node
Each machine create with unique name. 
Name and hostname of node must be same, for example with machine 1: hostname can be rabbit-1 and machine 2 can be rabbit-2

docker run -dit --name rabbit-1 --hostname rabbit-1 -p 5672:5672 -p 15672:15672 --net rabbitmq-network rabbitmq-cluster:latest

## Join cluster
Do repeatly each nodes. Before join to cluster, new node will be reseted and loss all data.
For example with node rabbit-2:

Access to container:

docker exec -it rabbit-2 bash

Stop rabbitmq_app:

rabbitmqctl stop_app

Reset rabbit_app before join to cluster:

rabbitmq reset

Join cluster:

rabbitmqctl join_cluster rabbit@rabbit-1

Start app:

rabbitmqctl start_app