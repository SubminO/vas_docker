#!/bin/sh

#if [ -z "$MODE" ]
#then
#    MODE="development"
#fi

cd /opt/keeper

python ./run.py --wsaddr "translator" --wsport $WS_PORT --gbhost $GDB_HOST --gbport $GDB_PORT \
 --gbdb $GDB_DBNAME --location $LOCATION --rradius $ROUTE_RADIUS --pradius $PLATFORM_RADIUS \
 --dbshost $DBS_HOST --dbsuser $DBS_USER --dbspass $DBS_PASS --dbsdb $DBS_DBNAME --rmqhost $RMQ_HOST \
 --rmquser $RMQ_USER --rmqpass  $RMQ_PASS