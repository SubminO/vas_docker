#!/bin/sh

#if [ -z "$MODE" ]
#then
#    MODE="development"
#fi

cd /opt/beholder

python ./run.py --wsaddr $WS_ADDR --wsport $WS_PORT \
 --rmqhost $RMQ_HOST --rmquser $RMQ_USER --rmqpass $RMQ_PASS