FROM rabbitmq:3-management

COPY rabbitmq-qq.conf /etc/rabbitmq/rabbitmq.conf
COPY rabbitmq-qq-definitions.json /etc/rabbitmq/rabbitmq-definitions.json

ENV RABBITMQ_ERLANG_COOKIE cookieSecret

# Rabbit cluster use 3 port:
# 4369: rabbitmq use to interact other nodes
# 5672: service port
# 15672: management port
EXPOSE 4369 5672 15672
