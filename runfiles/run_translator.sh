#!/bin/bash

DEBUG=1

if [ $MODE -eq "production" ]; then
      DEBUG=0
fi

PROTOPORTS=""
for PROTOPORT in $PROTOCOLS; do
    PROTOPORTS="$PROTOPORTS -r $(echo $PROTOPORT | sed  's/:/ /')"
done

cd /opt/translator

python ./run.py $PROTOPORTS --wsaddr $WS_ADDR \
    --wsport $WS_PORT --addr $TRANS_ADDR -d $DEBUG


