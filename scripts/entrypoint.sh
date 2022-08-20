#!/bin/bash
/gwn/gwn start

LOGFILE=/gwn/logs/gwn/web/system.log

if [ -f $LOGFILE ]; then
    tail -f /gwn/logs/gwn/web/system.log
fi