#!/bin/sh

DEBUG='-d'

if [ "x$MODE" == "xproduction" ]
then
      DEBUG=''
fi

PROTOPORTS=""
for PROTOPORT in $PROTOCOLS
do
    PROTOPORTS="$PROTOPORTS -r $(echo $PROTOPORT | sed  's/:/ /')"
done

cd /opt/translator

python ./run.py $PROTOPORTS -w $WS_ADDR -p $WS_PORT -l $TRANS_ADDR $DEBUG