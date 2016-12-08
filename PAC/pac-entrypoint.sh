#!/bin/sh
while true; do
  exec /dnspacmaker.sh
  sleep $UPDATE_TIME
done
